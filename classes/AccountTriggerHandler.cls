public with sharing class AccountTriggerHandler {
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    
    public AccountTriggerHandler(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
    }
    
    // This method for preventing deletion of master account
    public void OnBeforeDelete(Account[] oldRecords){
        AccountActions.deleteMasterAccount(oldRecords);
    }
    
    //added code snippet for preventing merge opeartion if it is done by other than CS managers with qualified account
    public void OnAfterDelete(Account[] deletedRecords, Map<ID, Account> recordMap){
        AccountActions.mergeActiveAccount(deletedRecords,recordMap);
        AccountActions.createPlatformEvent(deletedRecords,'Delete');

    }
    
    public void OnBeforeInsert(Account[] newRecords){
        //AccountActions.sendAccountsToLims(newRecords,'new');
    }
    
    public void OnAfterInsert(Account[] newRecords){
        if(!system.isBatch()){
            AccountActions.sendQualifiedAccountsToLims(newRecords,'new');
            AccountActions.createplatformevent(newRecords,'new');
        }
    }
    public void OnAfterInsert_Map(Map<ID,Account> newRecords){
      /*  GHGlobalActions.createAccountSelfGHGlobal(newRecords,'Commercial');
        GHGlobalActions.createAccountSelfGHGlobal(newRecords,'Biopharma');
        Map<ID, Account> newRecordswithParentAcc = new Map<ID, Account>();
        Map<ID, Account> newRecordswithSponsorAcc = new Map<ID, Account>();
        if(newRecords != null){
            for(Account acc : newRecords.values()){
                if(acc.ParentID != null){
                    newRecordswithParentAcc.put(acc.ID, acc);
                }
                if(acc.Sponsor_Account__c != null){
                    newRecordswithSponsorAcc.put(acc.ID, acc);
                }
            }
        }
        if(newRecordswithParentAcc != null && newRecordswithParentAcc.size() > 0){
            GHGlobalActions.createAccountToAccount_ParentGHGlobal(newRecordswithParentAcc);   
        }
        if(newRecordswithSponsorAcc != null && newRecordswithSponsorAcc.size() > 0){
            GHGlobalActions.createAccountToAccount_SponsorGHGlobal(newRecordswithSponsorAcc);   
        }*/
    }
    
    //@future public static void OnAfterInsertAsync(Set<ID> newRecordIDs){
    //Example usage
    //List<Account> newRecords = [select Id, Name from Account where Id IN :newRecordIDs];
    //}
    
    public void OnBeforeUpdate(Account[] oldRecords, Account[] updatedRecords, Map<ID, Account> oldMap, Map<ID, Account> newMap){
        if(!system.isBatch()){
            AccountActions.sendChangesToLIMS(oldMap, newMap);
        }
    }
    
    public void OnAfterUpdate(Account[] oldRecords, Account[] updatedRecords, Map<ID, Account> oldMap, Map<ID, Account> newMap){
        //GHGlobalActions.updateAccountSelfGHGlobal(oldMap,newMap);
     /*   GHGlobalActions.udpateAccount_Account_ParentGHGlobal(oldMap,newMap);
        GHGlobalActions.udpateAccount_Account_SponsorGHGlobal(oldMap,newMap);*/
        AccountActions.createplatformevent(updatedRecords,'Update');

    }
    
    //@future public static void OnAfterUpdateAsync(Set<ID> updatedRecordIDs){
    //List<Account> updatedRecords = [select Id, Name from Account where Id IN :updatedRecordIDs];
    //}
    
    //public void OnBeforeDelete(Account[] recordsToDelete, Map<ID, Account> recordMap){
    
    //}
    
    //public void OnAfterDelete(Account[] deletedRecords, Map<ID, Account> recordMap){
    //  AccountActions.SendChangesToLIMS(recordMap, null);
    //}
    
    //@future public static void OnAfterDeleteAsync(Set<ID> deletedRecordIDs){
    
    //}
    
    //public void OnUndelete(Account[] restoredRecords){
    
    //}
    
    public boolean IsTriggerContext{
        get{ return m_isExecuting;}
    }
    
    public boolean IsVisualforcePageContext{
        get{ return !IsTriggerContext;}
    }
    
    public boolean IsWebServiceContext{
        get{ return !IsTriggerContext;}
    }
    
    public boolean IsExecuteAnonymousContext{
        get{ return !IsTriggerContext;}
    }
}