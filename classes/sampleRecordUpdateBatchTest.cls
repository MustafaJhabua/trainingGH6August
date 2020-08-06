@IsTest
public with sharing class sampleRecordUpdateBatchTest {

    @TestSetup
    public static void setupObjects(){
        AdminTriggerToggle__c toggle = new AdminTriggerToggle__c();
        toggle.BypassSampleUpdateTrigger__c = false;
        insert toggle;

        //Create Account
        Account a1 = (Account) TestFactory.createSObject(new Account(Account_Type__c = 'Clinical Account US'), true);
        //Create Contact
        Contact c1 = (Contact) TestFactory.createSObject(new Contact(AccountId = a1.Id),true);
        //Create Samples
        Guardant_360_Sample__c[] samples = (Guardant_360_Sample__c[]) TestFactory.createSObjectList(new Guardant_360_Sample__c(Contact__c = c1.Id, Account__c = a1.Id),10);
        for (Integer i = 0; i < samples.size(); i++) {
            Guardant_360_Sample__c sample = samples.get(i);
            sample.Date_Received__c = Date.today() - i;
        }
        insert samples;
    }


    @IsTest
    public static void sampleBatch() {
      
        test.starttest();
       Database.executeBatch(new sampleRecordUpdateBatch());
        test.stoptest();
    }

   
}