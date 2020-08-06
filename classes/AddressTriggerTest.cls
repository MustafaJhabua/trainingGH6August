@isTest
public class AddressTriggerTest {
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
        
        Address__c addObj1 = new Address__c();
        addObj1.Entity_VID__c = '789456';
        insert addObj1;
        
        Address__c addObj2 = new Address__c();
        addObj2.Entity_VID__c = '123456';
        insert addObj2;
    }
}