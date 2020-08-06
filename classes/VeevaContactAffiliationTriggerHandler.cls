public with sharing class VeevaContactAffiliationTriggerHandler {
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    
    public VeevaContactAffiliationTriggerHandler(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
    }
    
    public void OnBeforeInsert(Veeva_Contact_Affiliation__c[] newRecords){
        Set<String> entityVID_Contact = new Set<String>();
        Set<String> parentEntityVID_Account = new Set<String>();
        for(Veeva_Contact_Affiliation__c add : newRecords){
            if(add.Contact__c == null && add.Account__c == null && add.Entity_VID__c <> null && add.Parent_HCO_VID__c <> null){
                entityVID_Contact.add(add.Entity_VID__c);
                parentEntityVID_Account.add(add.Parent_HCO_VID__c);
            }
        }
        
        List<Account> accList = [Select ID, Name,Veeva_ID__c from Account where Veeva_ID__c =: parentEntityVID_Account];
        List<Contact> conList = [Select ID, Name,Veeva_ID__c from Contact where Veeva_ID__c =: entityVID_Contact];
        System.debug('accList - '+ accList);
        System.debug('conList - '+ conList);
        Map<String, Account> accMap = new Map<String, Account>();
        Map<String, Contact> conMap = new Map<String, Contact>();
        
        for(Account acc : accList){
            accMap.put(acc.Veeva_ID__c, acc);
        }
        
        for(Contact con : conList){
            conMap.put(con.Veeva_ID__c, con);
        }
        
        for(Veeva_Contact_Affiliation__c add : newRecords){
            if(add.Contact__c == null && add.Account__c == null && add.Entity_VID__c <> null && add.Parent_HCO_VID__c <> null){
                Account acc = accMap.get(add.Parent_HCO_VID__c);
                Contact con = conMap.get(add.Entity_VID__c);
                System.debug('acc - '+ acc);
                System.debug('con - '+ con);
                if(acc != null){
                    add.Account__c = acc.Id;
                }
                if(con != null){
                    add.Contact__c = con.Id;
                }
            }
        }
    }
    
    public void OnAfterInsert(Veeva_Contact_Affiliation__c[] newRecords){
        
    }
    
    @future public static void OnAfterInsertAsync(Set<ID> newRecordIDs){
        
    }
    
    public void OnBeforeUpdate(Affilation__c[] oldRecords, Affilation__c[] updatedRecords, Map<ID, Affilation__c> oldMap, Map<ID, Affilation__c> newMap){
        
    }
    
    public void OnAfterUpdate(Affilation__c[] oldRecords, Affilation__c[] updatedRecords, Map<ID, Affilation__c> oldMap, Map<ID, Affilation__c> newMap){
    }
    
    @future public static void OnAfterUpdateAsync(Set<ID> updatedRecordIDs){
        
    }
    
    public void OnBeforeDelete(Affilation__c[] recordsToDelete, Map<ID, Affilation__c> recordMap){
        
    }
    
    public void OnAfterDelete(Affilation__c[] deletedRecords, Map<ID, Affilation__c> recordMap){
        
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