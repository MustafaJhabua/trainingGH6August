@IsTest(SeeAllData=false)
public class DelayedCaseTest {

    public static testmethod  void DelayedCaseTestMethod1(){
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
        Test.startTest();
        Test.setCurrentPageReference(new PageReference('Page.sampleButton'));
        System.currentPageReference().getParameters().put('id', samples[0].id);
        ApexPages.StandardController apx = new ApexPages.StandardController(samples[0]);
        DelayedCaseController  ds= new DelayedCaseController(apx);
        ds.autoRun();
        DelayedCaseCheckbox.updatingSample(samples[0].id);
        Test.stopTest();
    }
}