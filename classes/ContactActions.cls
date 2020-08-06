public with sharing class ContactActions {
    public static final string FIELDSET_NAME = 'LIMS_Contact_Change_Tracking';

    public static void SendChangesToLIMS(Map<ID, Contact> oldRecordMap, Map<ID, Contact> newRecordMap) {
        List<Id> accountsNotInLIMS = new List<Id>();
        List<Contact> changedRecords = new List<Contact>(); //list records to send
        //Based on values passed, determine if new, update or delete.
        String dmlType = '';
        if (oldRecordMap != null && newRecordMap != null)dmltype = 'update';

        system.debug('===dmlType: ' + dmltype);
        if (dmlType == 'update') {

            string objectLabel = string.valueOf(oldRecordMap.getSObjectType().getDescribe().getLabel());

            List<Schema.FieldSetMember> trackedFields = Lims.LookupTrackedFields(new String[]{
                    'Contact'
            }, FIELDSET_NAME);

            for (ID recordID : newRecordMap.keySet()) {
                Boolean trackedFieldChanged = false;
                Contact myNewRecord = newRecordMap.get(recordID);
                Contact myOldRecord = oldRecordMap.get(recordID);

                for (Schema.FieldSetMember fsm : trackedFields) {
                    String fieldName = fsm.getFieldPath();
                    String fieldLabel = fsm.getLabel();
                    if (myNewRecord.get(fieldName) != myOldRecord.get(fieldName))trackedFieldChanged = true;
                }

                if (trackedFieldChanged)changedRecords.add(myNewRecord);
            }
        }
        sendContactsToLims(changedRecords, 'update');
    }

    //public static void sendNewContactsToLIMS(List<Contact> contactRecords){
    //  sendContactsToLims(contactRecords,'new',true);
    //}

    public static void sendContactsToLims(List<Contact> contactRecords, String dmlType) {
        List<Contact> contactsToUpdate = new List<Contact>();
        for (Contact c : contactRecords) {
            Boolean accountAndContactQualified = c.Qualified__c && c.Account_Qualified__c;
            if (accountAndContactQualified || c.Push_to_labvantage__c) {
                String jsonPayload = BuildPayload(c, dmlType);
                Lims.sendToLIMS(jsonPayload);
                String currentTime = String.valueOf(datetime.now());
                if (dmlType == 'new') {
                    contactsToUpdate.add(new Contact(Id = c.Id, Sent_to_LIMS__c = currentTime));
                } else {
                    c.Sent_to_LIMS__c = currentTime;//Timestamp Accounts with system time of SMS sending
                }
            }
        }
        if (contactsToUpdate.size() != 0 && !System.isQueueable() && Limits.getQueueableJobs() == 0) {
            System.enqueueJob(new QUEUEABLE_ContactUpdate(contactsToUpdate));
        }
    }

     public static void createPlatformEvent(List<Contact> contactRecords, String dmlType){
       
        List<ModifiedRecord__e> publishEvents = new List<ModifiedRecord__e>();
        for(Contact con : contactRecords){
            ModifiedRecord__e    eve = new ModifiedRecord__e();
            eve.ObjectName__c = 'Contact' ; 
            eve.recordid__C= con.id ; 
            if(dmlType == 'Delete'){
            eve.IsDeleted__c =true;
            }
            else{
             eve.IsDeleted__c =false;

            }
            
            publishEvents.add(eve);            
        }
        if(publishEvents.size()>0){
            EventBus.publish(publishEvents);
        }
    }
    
    public static string BuildPayload(Contact c, String type) {
        //if contact updated but no timestamp from previous send, mark type as new
        if (String.isBlank(c.Sent_To_LIMS__c)) {
            type = 'new';
        }
        Lims.Physician phy = new Lims.Physician();
        phy.Object_id = 'Contact';
        phy.Status = type;
        phy.details.AccountLinked = String.valueOf(!c.Account_in_LIMS__c);                      //Boolean
        phy.details.first_name = c.FirstName;                                                   //String(40)
        phy.details.last_name = c.LastName;                                                     //String(80)

        phy.details.fax = c.Fax;                                                                //String(40)
        phy.details.contact_id = c.Case_Safe_Contact_ID__c;                                     //String(18)
        phy.details.account_id = c.AccountId;                                                   //String(18)
        phy.details.npi_no = c.NPI_Number__c;                                                   //String(25)
        phy.details.needs_treatment = String.valueOf(c.Needs_Treatment__c);                     //Boolean 
        phy.details.billing_indicator = c.Physician_Billing_Type__c;                            //String(255)
        phy.details.is_newyork_physician = String.valueOf(c.New_York_Sample__c);                //Boolean
        phy.details.is_qualified = String.valueOf(c.Qualified__c);                              //Boolean
        phy.details.push_to_labvantage = String.valueOf(c.push_to_labvantage__c);               //Boolean
        phy.details.email_address = c.Email;                                                    //String(80)
        phy.details.report_delivery_method = c.Delivery_Report_Type__c;                         //String(255)
        phy.details.is_secondary_physician = String.valueOf(c.Is_Secondary_Physician__c);       //Boolean
        phy.details.user_name = c.Portal_User_Name__c;                                          //String(80)
        phy.details.is_unqualified_by_cs = String.valueOf(c.Unqualified_by_CS__c);
        phy.details.report_additional_information = String.valueOf(c.Needs_Long_Report__c);
        if(c.Exceeded_SL_Limit_Threshold_Date__c != null){
            phy.details.threshold_date = String.valueOf(c.Exceeded_SL_Limit_Threshold_Date__c.format());
        }
        return JSON.serialize(phy);
    }

    public static List<Contact> queryContacts(List<Contact> contactsToQuery) {
        return [
                SELECT id
                        ,FirstName
                        ,LastName
                        ,Phone
                        ,Fax
                        ,Case_Safe_Contact_ID__c
                        ,NPI_Number__c
                        ,Needs_Treatment__c
                        ,Physician_Billing_Type__c
                        ,New_York_Sample__c
                        ,Qualified__c
                        ,Email
                        ,Delivery_Report_Type__c
                        ,Is_Secondary_Physician__c
                        ,Push_to_labvantage__c
                        ,Portal_User_Name__c
                        ,Unqualified_by_CS__c
                        ,Qualified_to_send_to_LIMS__c
                        ,Sent_To_LIMS__c
                        ,Account_in_LIMS__c
                        ,AccountId
                        ,Account_Qualified__c
                        ,Needs_Long_Report__c
                        ,Exceeded_SL_Limit_Threshold_Date__c
                        FROM Contact
                        WHERE Id in : contactsToQuery
        ];
    }

}