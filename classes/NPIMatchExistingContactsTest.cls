@IsTest
public class NPIMatchExistingContactsTest {
    private static testMethod void myUnitTest() {


        Account acc = (Account) TestFactory.createSObject(new Account(
                Name = 'testName',
                Account_Type__c = 'Clinical Account US',
                RecordTypeId = '01234000000HoYZ',
                Delivery_Report_Type__c = 'Email',
                BillingCountry = 'US',
                BillingPostalCode = '01234'),true);

        Contact con = (Contact)TestFactory.createSObject(new Contact(
                LastName = 'Test01',
                NPI_Matched__c = false,
                NPI_Number__c = '7657889567',
                AccountId = acc.Id,
                Request_a_Kit_Details__c = 'chandra1112s112,kumar,7657889567,chandra111@gmail.com, younesh,RY,younesh123@gmail.com,practiveEmail,morabadi,ranchi,jharkhand,01234,BREAST CANCER'
        ),true);

        con.Request_a_Kit_Details__c = 'chandra1112112,kumar,7657889567,chandra11145@gmail.com, younesh,RY,younesh123@gmail.com,practiveEmail,morabadi,ranchi,jharkhand,01234,BREAST CANCER';
        update con;
    }

}