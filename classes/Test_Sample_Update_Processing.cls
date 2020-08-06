@IsTest
public class Test_Sample_Update_Processing {
    
    static testmethod void Sample_Update_Processing() {

        Account[] testAccounts = (Account[])TestFactory.createSObjectList(new Account(),25,true);
        List<Contact> testContacts = new List<Contact>();
        for(Account acc : testAccounts){
            testContacts.add((Contact)TestFactory.createSObject(new Contact(AccountId = acc.Id)));
        }
        insert testContacts;

        List<Guardant_360_Sample__c > lstTRF = new List< Guardant_360_Sample__c>();

        Guardant_360_Sample__c objTRF = null;
        integer intSampleId = 0;
        for(Contact c: testContacts) {
            for(integer i = 0; i < 3; i++) {
                objTRF = new Guardant_360_Sample__c(Name =i.format() + intSampleId.format(), Account__c = c.AccountId, Contact__c = c.id);
                if(i == 0) {
                    objTRF.Date_Received__c = Date.today();
                } else if( i ==1 ) {
                    objTRF.Date_Received__c = Date.today().addDays(2);
                } else {
                    objTRF.Date_Received__c = Date.today().addDays(-2);
                }
                lstTRF.add(objTRF);
                intSampleId++;
            }
        }

        insert lstTRF;
    }
}