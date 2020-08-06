/****************************************************************
 Label Used for messages
  MasterAccountDeletionError - This label having message for preventing master account deletion
  MergerErrorMessage - This label having message if anyone other than CS Manager do merge on qualified account
*****************************************************************/
public with sharing class AccountActions {
    public static final string FIELDSET_NAME = 'LIMS_Account_Change_Tracking';

    public static void sendChangesToLIMS(Map<ID,Account> oldRecordMap, Map<ID,Account> newRecordMap){
        List<Account> changedRecords = new List<Account>(); //list records to send
        //Based on values passed, determine if new, update or delete.
        String dmlType = '';
        if(oldRecordMap != null && newRecordMap != null)dmltype = 'update';

        if(dmlType == 'update'){
            string objectLabel = string.valueOf(oldRecordMap.getSObjectType().getDescribe().getLabel());
            //string[] objectName = new string[]{string.valueOf(oldRecordMap.getSObjectType())};
            List<Schema.FieldSetMember> trackedFields = Lims.LookupTrackedFields(new String[]{'Account'},FIELDSET_NAME);
            
            
            for(ID recordID:newRecordMap.keySet()){
                Boolean trackedFieldChanged = false;
                Account myNewRecord = newRecordMap.get(recordID);
                Account myOldRecord = oldRecordMap.get(recordID);

                for (Schema.FieldSetMember fsm : trackedFields) {
                    String fieldName  = fsm.getFieldPath();
                    String fieldLabel = fsm.getLabel();
                    if (myNewRecord.get(fieldName) != myOldRecord.get(fieldName))trackedFieldChanged = true;
                }
                if(trackedFieldChanged)changedRecords.add(myNewRecord);
            }
        }

        sendQualifiedAccountsToLims(changedRecords,dmlType);
    }


    public static void sendQualifiedAccountsToLims(List<Account> accountRecords, String dmlType){
        List<Account> qualifiedAccounts = new List<Account>();
      for(Account a : accountRecords){
        if(a.Qualified__c)qualifiedAccounts.add(a);
      }
      sendAccountsToLims(qualifiedAccounts,dmltype);
    }
    
    public static void createPlatformEvent(List<Account> accountRecords, String dmlType){
       
        List<ModifiedRecord__e> publishEvents = new List<ModifiedRecord__e>();
        for(Account a : accountRecords){
            ModifiedRecord__e    eve = new ModifiedRecord__e();
            eve.ObjectName__c = 'Account' ; 
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

    public static void sendAccountsToLims(List<Account> accountRecords, String dmlType){
        List<Account> accountsToUpdate = new List<Account>();
      for(Account a : accountRecords){
            System.debug('===Account: '+a);
            String jsonPayload = BuildPayload(a, dmlType);
            system.debug('jsonPayload***'+jsonPayload);
            Lims.sendToLIMS(jsonPayload);
            if(dmlType == 'new'){
              accountsToUpdate.add(new Account(Id = a.Id, Sent_to_LIMS__c = String.valueOf(datetime.now())));
            }else{
              a.Sent_to_LIMS__c = String.valueOf(datetime.now()); //Timestamp Accounts with system time of SMS sending
            }
            
        }
        //if(doUpdate)update accountRecords;
        if(accountsToUpdate.size() != 0 && !System.isQueueable() && Limits.getQueueableJobs() == 0) {
            System.enqueueJob(new QUEUEABLE_AccountUpdate(accountsToUpdate));
        }
    }

    public static string buildPayload(Account a, String type){
        
        String street1 = '';
        String street2 = '';
        if(a.BillingStreet != null){
          List<String> parsedStreet = new List<String>();
          parsedStreet = a.BillingStreet.split('\n',2);
          street1 = parsedStreet[0];
          if(parsedStreet.size() == 2)street2 = parsedStreet[1];
        }

        

        if(String.isBlank(a.Sent_To_LIMS__c)){type = 'new';}
        Lims.Practice acc = new Lims.Practice();
        acc.Object_id = 'Account';
        acc.Status = type;
        acc.details.account_id = a.Id;                //String(18)
        acc.details.account_number = a.Account__c;    //String(30)
        acc.details.name = a.Name;                    //String(255)
        acc.details.address_line1 = street1;  //String(255)
        acc.details.address_line2 = street2;  //String(255)
        acc.details.city = a.BillingCity;             //String(40)
        acc.details.state = a.BillingState;           //String(80)
        acc.details.country = a.BillingCountry;       //String(80)
        acc.details.zip = a.BillingPostalCode ;       //String(20)
        acc.details.fax = a.Fax;                      //String(40)
        acc.details.phone = a.Phone;                  //String(40)
        acc.details.is_qualified = String.valueOf(a.Qualified__c);
        acc.details.trialSiteNumber = String.valueOf(a.Trial_Site_Number__c);
        return JSON.serialize(acc);
    }
    
    // This method for preventing deletion of master account
    public static void deleteMasterAccount(List<Account> oldAccount){
        for(Account acc : oldAccount){
           if(acc.Is_Master__c){
            acc.addError(Label.MasterAccountDeletionError);

           }
        }
    }
    
    //This method for preventing merge opeartion if it is done by other than CS managers with qualified account
    public static void mergeActiveAccount(Account[] deletedRecords, Map<ID, Account> recordMap){
       for(Account acc: deletedRecords){
         if(acc.MasterRecordId != null && (acc.Qualified__c == true || acc.Unqualified_by_CS__c == true) && acc.RoleName__c != Label.ClientService){
            acc.addError(Label.MergerErrorMessage);
         }
        }
    }

}