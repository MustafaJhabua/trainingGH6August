public with sharing class AffiliationActions {

    public static final string FIELDSET_NAME = 'LIMS_Affiliation_Change_Tracking';

    public static void SendChangesToLIMS(Map<ID,Affilation__c> oldRecordMap, Map<ID,Affilation__c> newRecordMap){
        List<Affilation__c> changedRecords = new List<Affilation__c>(); //list records to send
        //Based on values passed, determine if new, update or delete.
        String dmlType = '';
        if(oldRecordMap != null && newRecordMap != null)dmltype = 'update';
        //if(oldRecordMap == null && newRecordMap != null){
        //  dmltype = 'new';
  //          for(Affilation__c myNewRecord : newRecordMap.values())
        //       if(myNewRecord.Account_Qualified__c &&
  //                      (myNewRecord.Push_to_Labvantage__c || myNewRecord.Qualified_AF__c))changedRecords.add(myNewRecord);
        //}
        //if(oldRecordMap != null && newRecordMap == null){
        //  dmltype = 'delete';
        //  changedRecords.add(oldRecordMap.values());
        //}

        if(dmlType == 'update'){

            string objectLabel = string.valueOf(oldRecordMap.getSObjectType().getDescribe().getLabel());
            List<Schema.FieldSetMember> trackedFields = Lims.LookupTrackedFields(new String[]{'Affilation__c'},FIELDSET_NAME);
         
            for(ID recordID:newRecordMap.keySet()){
                Boolean trackedFieldChanged = false;
                Affilation__c myNewRecord = newRecordMap.get(recordID);
                Affilation__c myOldRecord = oldRecordMap.get(recordID);

                for (Schema.FieldSetMember fsm : trackedFields) {
                    String fieldName  = fsm.getFieldPath();
                    String fieldLabel = fsm.getLabel();
                    if (myNewRecord.get(fieldName) != myOldRecord.get(fieldName))trackedFieldChanged = true;
                }
                if(trackedFieldChanged)changedRecords.add(myNewRecord);
            }
        }
        sendQualifiedAffiliationsToLims(changedRecords,dmlType);
        //List<Id> accountsNotInLIMS = new List<Id>();

        ////Loop through changed records and add to LIMS Objects
        ////Re-query so not read only
        //changedRecords = queryAffiliation(changedRecords);
        //for(Affilation__c a : changedRecords){
        //    System.debug('===Affiliation: '+a);
        //    String jsonPayload = BuildPayload(a, dmltype);
        //    Lims.sendToLIMS(jsonPayload);
        //    a.Sent_to_LIMS__c = String.valueOf(datetime.now()); //Timestamp Affiliation with system time of SMS sending
        //}
        ////if(dmltype == 'new') 
        //update changedRecords;
    }

    public static void sendQualifiedAffiliationsToLims(List<Affilation__c> affiliationRecords, String dmlType){
      List<Affilation__c> qualifiedAffiliations = new List<Affilation__c>();
      for(Affilation__c a : affiliationRecords){
        if(a.Account_Qualified__c &&
            (a.Push_to_Labvantage__c || a.Qualified_AF__c))qualifiedAffiliations.add(a);
      }
      sendAffiliationsToLims(qualifiedAffiliations,dmltype);
    }

    public static void sendAffiliationsToLims(List<Affilation__c> affiliationRecords, String dmlType){
      List<Affilation__c> affiliationsToUpdate = new List<Affilation__c>();
      for(Affilation__c a : affiliationRecords){
            System.debug('===Affiliation: '+a);
            String jsonPayload = BuildPayload(a, dmlType);
            Lims.sendToLIMS(jsonPayload);
            //if(dmlType == 'new'){
              affiliationsToUpdate.add(new Affilation__c(Id = a.Id, Sent_to_LIMS__c = String.valueOf(datetime.now())));
            //}else{
            //  a.Sent_to_LIMS__c = String.valueOf(datetime.now()); //Timestamp Accounts with system time of SMS sending
            //}
            
        }
        if(affiliationsToUpdate.size() != 0 && !System.isQueueable() && Limits.getQueueableJobs() == 0){
          System.enqueueJob(new QUEUEABLE_AffilationUpdate(affiliationsToUpdate));
        }
    }

    public static string BuildPayload(Affilation__c a, String type){
        Lims.Affiliation aff = new Lims.Affiliation();
        aff.Object_id = 'Affiliation';
        aff.Status = type;
        aff.details.AccountLinked = String.valueOf(!a.Account_in_LIMS__c);  //Boolean
        aff.details.affiliation_id = a.Id;                                  //String(18)
        aff.details.contact_id = a.Contact__c;                              //String(18)
        aff.details.account_id = a.Account__c;                              //String(18)    
        aff.details.user_name = a.Portal_User_Name__c;                      //String(80)
        aff.details.report_delivery_method = a.Delivery_Report_Type__c;     //String(255)
        aff.details.needs_treatment = String.valueOf(a.Needs_Treatment__c); //Boolean
        aff.details.is_newyork_physician = String.valueOf(a.NY_Sample__c);  //Boolean
        aff.details.billing_indicator = a.Physician_Billing_Type__c;        //String(255)
        aff.details.fax = a.Affiliated_Fax__c;                              //String(40)
        aff.details.other_npino = a.Other_NPI_No__c;
        aff.details.is_qualified = String.valueOf(a.Qualified_AF__c);
        aff.details.push_to_labvantage = String.valueOf(a.Push_to_Labvantage__c);
        aff.details.report_additional_information = String.valueOf(a.Needs_Long_Report__c);
        return JSON.serialize(aff);
    }
    
     public static void createPlatformEvent(List<Affilation__c> affRecords, String dmlType){
       
        List<ModifiedRecord__e> publishEvents = new List<ModifiedRecord__e>();
        for(Affilation__c a : affRecords){
            ModifiedRecord__e    eve = new ModifiedRecord__e();
            eve.ObjectName__c = 'Affilation__c' ; 
            eve.recordid__C= a.id ; 
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

}