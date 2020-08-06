@IsTest
public class Test_Data_Factory {

    public static List<Account> createAccounts(Integer intHowMany, User objOwner) {
        List<Account> lstAccount = new List<Account>();
        
        Account acc = null;   
        for(Integer x = 0; x < intHowMany; x++){
            acc = new Account(Name = 'test account', BillingCountry = 'US' , BillingState = 'CA');
            
            if(objOwner <> null) {
                acc.OwnerId = objOwner.Id;
            }
                                  
            if(x < 25) {
                acc.BillingStreet = '123 Main Street';
            } else if(x < 50) {
                acc.BillingStreet = '123 Main Street\nSuite 100';
            }       
                        
            lstAccount.add(acc);
        }
        return lstAccount;
    }   

    public static List<Contact> createContacts(List<Account> lstAcc) {
        List<Contact> lstContact = new List<Contact>();
        
        Contact objContact = null;        
        for(Account a: lstAcc) {
            objContact = new Contact(AccountId = a.Id, FirstName = 'Test', LastName = a.Name);
            lstContact.add(objContact);
        }
                
        return lstContact;
    }

    public static List<Case> createCases(List<Account> lstAcc, String txtRecordTypeId) {
        List<Case> lstCase = new List<Case>();
        
        Case cs = null;        
        for(Account a: lstAcc) {
            cs = new Case(AccountId = a.Id, RecordTypeId = txtRecordTypeId);
            lstCase.add(cs);
        }
                
        return lstCase;
    }

    public static List<Guardant_360_Sample__c> createTRFs(List<Contact> lstContact, Integer numTRFs, String prefix) {
        List<Guardant_360_Sample__c > lstTRF = new List< Guardant_360_Sample__c>();
        
        Guardant_360_Sample__c objTRF = null;
        integer intSampleId = 0;    
        for(Contact c: lstContact) {
            for(integer i = 0; i < numTRFs; i++) {
                objTRF = new Guardant_360_Sample__c(Name = prefix + i.format() + intSampleId.format(), Account__c = c.AccountId, Contact__c = c.id);
                if(i == 0) {
                    objTRF.Date_Received__c = Date.today();
                } else {
                    objTRF.Date_Received__c = Date.today().addDays(2);
                }
                lstTRF.add(objTRF);
                intSampleId++;
            }
        }
                
        return lstTRF;
    }
}