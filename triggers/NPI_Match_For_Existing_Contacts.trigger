trigger NPI_Match_For_Existing_Contacts on Contact (after update) {
    
    Map<Id,String> contactWithNPI = new Map<Id,String>();
    Map<ID,String> contactWithZipCode = new Map<Id,String>();
    List<Contact> ContactsToUpdate = new List<Contact> ();
    List<ID> affiliateCheck = new List<ID>();
    for(Contact cs:trigger.new){
        Contact oldCn = Trigger.oldMap.get(cs.Id);
            if(cs.Request_a_Kit_Details__c != null && cs.Request_a_Kit_Details__c != oldCn.Request_a_Kit_Details__c 
               && cs.NPI_Matched__c == false ){
                List<String> lstAlpha = cs.Request_a_Kit_Details__c.split(',');
                contactWithNPI.put(cs.Id,lstAlpha[2]); 
                contactWithZipCode.put(cs.Id,lstAlpha[11]); 
            }
    }
       
    if(!contactWithNPI.isEmpty()){
        for(Contact cn : [SELECT Id,NPI_Number__c,NPI_Matched__c ,account.Account_Type__c,account.BillingPostalCode,
                           (SELECT Id,account__r.BillingPostalCode,account__r.Account_Type__c FROM Affilations__r 
                            )
                           FROM Contact 
                          WHERE Id In: contactWithNPI.keySet()]){
            System.debug('cn' + cn.NPI_Number__c);
            Boolean IsSameZipCode = false;
                for(Affilation__c af: cn.Affilations__r){                     
                    if(af.account__r.BillingPostalCode == contactWithZipCode.get(cn.Id) && af.account__r.Account_Type__c =='Clinical Account US'){
                        IsSameZipCode = true ;  
                    }                    
                }
            if((cn.account.BillingPostalCode == contactWithZipCode.get(cn.Id) 
                && cn.NPI_Number__c==contactWithNPI.get(cn.Id) 
                && cn.account.Account_Type__c=='Clinical Account US') || 
                (IsSameZipCode == true && cn.NPI_Number__c==contactWithNPI.get(cn.Id))){
                    cn.NPI_Matched__c = true; 
                    System.debug('IsSameZipCode' + cn.NPI_Matched__c);
            }
            ContactsToUpdate.add(cn);  
        }
        Update ContactsToUpdate;
    }
}