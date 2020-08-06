@isTest(SeeAllData=false)
public class ContactActionsTest {

	@testSetup
	public static void setupObjects(){
		AdminTriggerToggle__c toggle = new AdminTriggerToggle__c();
		toggle.Bypass_Contact_Trigger__c = false;
		insert toggle;
		//Create Account
		Account a1 = (Account) TestFactory.createSObject(new Account(Account_Type__c = 'Clinical Account US'), true);
		//Create Contact
		Contact c1 = (Contact) TestFactory.createSObject(new Contact(AccountId = a1.Id),true);
	}

	public static testMethod void test_buildPayload(){
		List<Contact> contactsList = [SELECT id FROM Contact LIMIT 1];
		contactsList = ContactActions.queryContacts(contactsList);
		ContactActions.BuildPayload(contactsList[0],'new');
	}
	
	public static testMethod void test_contactTriggerHandler() {
		Contact con = [SELECT id FROM Contact LIMIT 1];
		delete con;
		undelete con;
		ContactTriggerHandler handler = new ContactTriggerHandler(false,0);
		Boolean isTrigger = handler.IsTriggerContext;
		Boolean isVFPage = handler.IsVisualforcePageContext;
		Boolean isWS = handler.IsWebServiceContext;
		Boolean isAnon = handler.IsExecuteAnonymousContext;
	}	
}