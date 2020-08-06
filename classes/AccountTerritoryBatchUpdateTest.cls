@IsTest
public class AccountTerritoryBatchUpdateTest{

    public static testmethod void test_AccountTerritoryBatchUpdate() {
        Account a1 = (Account) TestFactory.createSObject(new Account(Account_Type__c = 'Clinical Account US',BillingPostalCode ='75006'), true);
        Zip_Code__c zip = new Zip_Code__c(Territory__c='texas',Region__c='texas',name='75006');
        insert zip;
        Test.startTest();
        AccountTerritoryBatchUpdate acc = new AccountTerritoryBatchUpdate();
        database.executebatch(acc,1);
        Test.StopTest();

    }
    
    public static testmethod void test_AdminBatchExecuteController() {

    AdminBatchExecuteController adm = new AdminBatchExecuteController();
    adm.runTerritoryBatch();
    adm.runMatchBatch();
    
    } 
}