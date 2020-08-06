@isTest(SeeAllData=false)
public class LimsTest {

	@testSetup
	public static void SetupObjects(){
		//Set up Custom Settings
		AWS_Credentials__c conf = new AWS_Credentials__c();
		conf.Physician_Update_Access_Key__c = 'accesskey';
		conf.Physician_Update_Secret_Key__c = 'secret';
		conf.Physician_Update_SQS_Base_URL__c = 'www.example.com';
		conf.Physician_Update_SQS_Queue__c = '/queuepath';
		insert conf;
	}
	
	public static testMethod void test_method_one() {
		// Implement test code
	}
	
	public static testMethod void test_method_two() {
		// Implement test code
	}
	
}