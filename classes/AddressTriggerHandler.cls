public class AddressTriggerHandler {
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    
    public AddressTriggerHandler(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
    }
    public void OnBeforeInsert(Address__c[] newRecords){
        Set<String> entityVID = new Set<String>();
        for(Address__c add : newRecords){
            if(add.Contact__c == null && add.Account__c == null && add.Entity_VID__c <> null){
                entityVID.add(add.Entity_VID__c);
            }
        }
        
        List<Account> accList = [Select ID, Name,Veeva_ID__c from Account where Veeva_ID__c =: entityVID];
        List<Contact> conList = [Select ID, Name,Veeva_ID__c from Contact where Veeva_ID__c =: entityVID];
        
        Map<String, Account> accMap = new Map<String, Account>();
        Map<String, Contact> conMap = new Map<String, Contact>();
        
        for(Account acc : accList){
            accMap.put(acc.Veeva_ID__c, acc);
        }
        
        for(Contact con : conList){
            conMap.put(con.Veeva_ID__c, con);
        }
        
        for(Address__c add : newRecords){
            if(add.Contact__c == null && add.Account__c == null && add.Entity_VID__c <> null){
                Account acc = accMap.get(add.Entity_VID__c);
                Contact con = conMap.get(add.Entity_VID__c);
                
                if(acc != null){
                    add.Account__c = acc.Id;
                }
                else if(con != null){
                    add.Contact__c = con.Id;
                }
            }
        }
    }
}