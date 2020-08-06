@isTest
public class VeevaContactAffiliationTriggerTest {
@isTest
    public static void test1(){
        
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Veeva_ID__c = '123456';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact';
        con.Veeva_ID__c = '789456';
        con.AccountId = acc.Id;
        insert con;
        
        Veeva_Contact_Affiliation__c vcaObj = new Veeva_Contact_Affiliation__c();
        vcaObj.Entity_VID__c = '789456';
        vcaObj.Parent_HCO_VID__c = '123456';
        insert vcaObj;
    }
}