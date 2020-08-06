@isTest
public class AccountExtensionControllerTest {
    @isTest
    public static void test1(){
        Account acc= new Account();
        acc.Name = 'Test Account';
        acc.Veeva_ID__c = '867797997798';
        insert acc;
        
        Test.StartTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        AccountExtensionController testAccPlan = new AccountExtensionController(sc);
        PageReference pageRef = Page.VeevaWidget_AccountVFPage;
        pageRef.getParameters().put('id', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        
        Test.StopTest();
    }
}