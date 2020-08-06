@IsTest
public class Create_Update_lead_Contact_Test {

    private static testMethod void myUnitTest() {
        Account acc = (Account) TestFactory.createSObject(new Account(
                Name = 'testName',
                Account_Type__c = 'Clinical Account US',
                RecordTypeId = '01234000000HoYZ',
                Delivery_Report_Type__c = 'Email',
                BillingCountry = 'US',
                BillingPostalCode = '01234'), true);

        TestFactory.createSObject(new Contact(
                LastName = 'Test01',
                NPI_Matched__c = false,
                NPI_Number__c = '7657889567',
                AccountId = acc.Id), true);

        TestFactory.createSObject(new Lead(
                LastName = 'Leadtest',
                Company = 'Comp INC',
                NPI_Number__c = '7657889567',
                PostalCode = '01234',
                Primary_Cancer_Type__c = 'testtype',
                Status = 'Open'),true);
    }
}