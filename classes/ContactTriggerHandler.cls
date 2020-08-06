/*****************************************
     Modified By    Description 
      
      Siva           added code snippet for preventing merge opeartion if it is done by other than CS managers 
                      with qualified account's related contact
************************************************/

public with sharing class ContactTriggerHandler {
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    
    public ContactTriggerHandler(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
    }
    
    public void OnBeforeInsert(Contact[] newRecords){
    }
    
    public void OnAfterInsert(Contact[] newRecords){
        ContactActions.sendContactsToLims(newRecords,'new');
      //  ContactActions.createPlatformEvent(newRecords,'new');
    }
    public void OnAfterInsert_Map(Map<ID,Contact> newRecords){
       /* GHGlobalActions.createContactSelfGHGlobal(newRecords);
        GHGlobalActions.createAccount_Contact_PrimaryGHGlobal(newRecords,'Primary Account Linked');*/
    }
    
//  @future public static void OnAfterInsertAsync(Set<ID> newRecordIDs){
//      //Example usage
//      //List<Contact> newRecords = [select Id, Name from Contact where Id IN :newRecordIDs];
//  }
    
    public void OnBeforeUpdate(Contact[] oldRecords, Contact[] updatedRecords, Map<ID, Contact> oldMap, Map<ID, Contact> newMap){
        if(!System.isBatch() && !System.isFuture()){
            ContactActions.SendChangesToLIMS(oldMap, newMap);
        }
        
      

    } 
    
    public void OnAfterUpdate(Contact[] oldRecords, Contact[] updatedRecords, Map<ID, Contact> oldMap, Map<ID, Contact> newMap){
        //GHGlobalActions.updateContactSelfGHGlobal(oldMap,newMap);
       // GHGlobalActions.udpateAccount_Contact_PrimaryGHGlobal(oldMap,newMap);
       // ContactActions.createPlatformEvent(updatedRecords,'Update');

    }
    
//  @future public static void OnAfterUpdateAsync(Set<ID> updatedRecordIDs){
//      //List<Contact> updatedRecords = [select Id, Name from Contact where Id IN :updatedRecordIDs];
//  }
    
    public void OnBeforeDelete(Contact[] recordsToDelete, Map<ID, Contact> recordMap){
        
    }
    
    //added code snippet for preventing merge opeartion if it is done by other than CS managers 
                    //  with qualified account's related contact
    public void OnAfterDelete(Contact[] deletedRecords, Map<ID, Contact> recordMap){
        //ContactActions.SendChangesToLIMS(recordMap, null);
          for(contact con : deletedRecords){
         if(con.MasterRecordId != null && con.QualifiedAccount__c == true && con.RoleName__c != Label.ClientService){
            con.addError(Label.MergeContactErrorMessage);
         }
        }
        
      //  ContactActions.createPlatformEvent(deletedRecords,'Delete');

    }
    
//  @future public static void OnAfterDeleteAsync(Set<ID> deletedRecordIDs){
//
//  }
    
    public void OnUndelete(Contact[] restoredRecords){
        
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