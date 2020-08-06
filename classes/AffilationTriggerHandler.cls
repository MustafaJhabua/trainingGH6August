public with sharing class AffilationTriggerHandler {
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    
    public AffilationTriggerHandler(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
    }
    
    public void OnBeforeInsert(Affilation__c[] newRecords){
        
    }
    
    public void OnAfterInsert(Affilation__c[] newRecords){
        AffiliationActions.sendQualifiedAffiliationsToLims(newRecords,'new');
        AffiliationActions.createPlatformEvent(newRecords, 'Create');
    }
    public void OnAfterInsert_Map(Map<ID,Affilation__c> newRecords){
        //GHGlobalActions.createContactAffiliationGHGlobal(newRecords);
    }
    @future public static void OnAfterInsertAsync(Set<ID> newRecordIDs){
        //Example usage
        //List<Affilation__c> newRecords = [select Id, Name from Affilation__c where Id IN :newRecordIDs];
    }
    
    public void OnBeforeUpdate(Affilation__c[] oldRecords, Affilation__c[] updatedRecords, Map<ID, Affilation__c> oldMap, Map<ID, Affilation__c> newMap){
        //Example Map usage
        //Map<ID, Contact> contacts = new Map<ID, Contact>( [select Id, FirstName, LastName, Email from Contact where AccountId IN :recordMap.keySet()] );
    }
    
    public void OnAfterUpdate(Affilation__c[] oldRecords, Affilation__c[] updatedRecords, Map<ID, Affilation__c> oldMap, Map<ID, Affilation__c> newMap){
        AffiliationActions.SendChangesToLIMS(oldMap, newMap);
        //GHGlobalActions.updateContactAffiliationGHGlobal(oldMap, newMap);
        AffiliationActions.createPlatformEvent(updatedRecords, 'Update');


    }
    
    @future public static void OnAfterUpdateAsync(Set<ID> updatedRecordIDs){
        //List<Affilation__c> updatedRecords = [select Id, Name from Affilation__c where Id IN :updatedRecordIDs];
    }
    
    public void OnBeforeDelete(Affilation__c[] recordsToDelete, Map<ID, Affilation__c> recordMap){
        
    }
    
    public void OnAfterDelete(Affilation__c[] deletedRecords, Map<ID, Affilation__c> recordMap){
        AffiliationActions.SendChangesToLIMS(recordMap, null);
        AffiliationActions.createPlatformEvent(deletedRecords, 'Delete');

    }
    
    @future public static void OnAfterDeleteAsync(Set<ID> deletedRecordIDs){
        
    }
    
    public void OnUndelete(Affilation__c[] restoredRecords){
        
    }
    
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