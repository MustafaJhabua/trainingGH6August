@isTest(SeeAllData=false)
public class AffiliationActionsTest {

	@testSetup
	public static void SetupObjects(){
		AdminTriggerToggle__c toggle = new AdminTriggerToggle__c();
		toggle.Bypass_Affiliation_Trigger__c = false;
		insert toggle;

		//Create Account
		Account a1 = (Account) TestFactory.createSObject(new Account(), true);
		//Create Account
		Account a2 = (Account) TestFactory.createSObject(new Account(), true);
		//Create Contact
		Contact c1 = (Contact) TestFactory.createSObject(new Contact(AccountId = a1.Id),true);
		//Create Contact
		Contact c2 = (Contact) TestFactory.createSObject(new Contact(AccountId = a2.Id),true);
		//Create Affiliation
		Affilation__c aff = (Affilation__c) TestFactory.createSObject(new Affilation__c(Account__c = a1.Id, Contact__c = c2.Id),true);
	}
	
	public static testMethod void test_sendNewAffiliationToLims() {
		Map<Id,Affilation__c> affiliationMap = new Map<Id,Affilation__c>([SELECT id
																				,Name
																				,Qualified_to_send_to_LIMS__c
																				,Account_in_LIMS__c
																				,Contact__c
																				,Account__c
																				,Portal_User_Name__c
																				,Delivery_Report_Type__c
																				,Needs_Treatment__c
																				,NY_Sample__c
																				,Physician_Billing_Type__c
																				,Affiliated_Fax__c
                                                                          		,Other_NPI_No__c
                                                                          		,Qualified_AF__c
                                                                          		,Push_to_Labvantage__c
																				,Needs_Long_Report__c
																		  FROM Affilation__c]);
		Test.startTest();
		AffiliationActions.SendChangesToLIMS(null, affiliationMap);
		AffiliationActions.SendChangesToLIMS(affiliationMap, null);
		AffiliationActions.SendChangesToLIMS(affiliationMap, affiliationMap);
		AffiliationActions.BuildPayload(affiliationMap.values()[0],'Test');
		Test.stopTest();
	}
	
	public static testMethod void test_affiliationTriggerHandler() {
		Affilation__c aff = [SELECT id FROM Affilation__c LIMIT 1];
		delete aff;
		undelete aff;
		AffilationTriggerHandler handler = new AffilationTriggerHandler(false,0);
		Boolean isTrigger = handler.IsTriggerContext;
		Boolean isVFPage = handler.IsVisualforcePageContext;
		Boolean isWS = handler.IsWebServiceContext;
		Boolean isAnon = handler.IsExecuteAnonymousContext;

	}	
}