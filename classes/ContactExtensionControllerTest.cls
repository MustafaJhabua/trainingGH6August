@isTest
public class ContactExtensionControllerTest {
    @isTest
    public static void test1(){
        Account acc = new Account();
        acc.Name = 'test Account';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact Last name';
        con.Veeva_ID__c = '867797997798';
        con.AccountId = acc.Id;
        insert con;
        
        Test.StartTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(con);
        ContactExtensionController testAccPlan = new ContactExtensionController(sc);
        PageReference pageRef = Page.VeevaWidget_ContactVFPage;
        pageRef.getParameters().put('id', String.valueOf(con.Id));
        Test.setCurrentPage(pageRef);
        
        Test.StopTest();
    }
}