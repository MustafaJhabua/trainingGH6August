@IsTest(SeeAllData=false)
public class AccountActionsTest {

    @TestSetup
    public static void SetupObjects(){
        AdminTriggerToggle__c toggle = new AdminTriggerToggle__c();
        toggle.Bypass_Account_Trigger__c = false;
        insert toggle;
        //Create Account
        TestFactory.createSObject(new Account(), true);
    }
    @IsTest
    public static void test_sendAccountsToLims() {
        List<Account> accounts = [
                SELECT
                        Id,
                        Name,
                        BillingStreet,
                        BillingCity,
                        Phone,
                        Fax,
                        Sent_to_LIMS__c,
                        Account__c,
                        BillingState,
                        BillingCountry,
                        BillingPostalCode,
                        Qualified__c,
                        AccountNumber,
                        Account_Type__c,
                        Billing_Street_1__c,
                        Billing_Street_2__c,
                        BillingLatitude,
                        BillingLongitude,
                        Qualified_to_send_to_LIMS__c,
                        Push_to_LabVantage__c, 
                        Trial_Site_Number__c  
                FROM Account];
        Test.startTest();
        AccountActions.sendAccountsToLims(accounts, 'new');
        AccountActions.sendChangesToLIMS(new Map<Id,Account>(accounts), new Map<Id,Account>(accounts));
        AccountActions.buildPayload(accounts[0],'new');
        Test.stopTest();
    }
    @IsTest
    public static void test_accountTriggerHandler() {
         Account a1 = (Account) TestFactory.createSObject(new Account(Account_Type__c = 'Clinical Account US'), true);
         delete a1;
        //delete a;
        //undelete a;
        AccountTriggerHandler handler = new AccountTriggerHandler(false,0);
        Boolean isTrigger = handler.IsTriggerContext;
        Boolean isVFPage = handler.IsVisualforcePageContext;
        Boolean isWS = handler.IsWebServiceContext;
        Boolean isAnon = handler.IsExecuteAnonymousContext;

    }
}