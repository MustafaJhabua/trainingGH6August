@IsTest
public class requestaKitFormControllerTest {

    public static testmethod void requestAKitMethodwithoutContact(){
    
    string inputString = 'test;#lastna;#2827262544;#tesbscgsgb@gmail.com;#prfirst;#prlast;#vkdckdfke@gmail.com;#sjdsajddd;#sjdfh;#SA;#CA;#12345;#hdfshd;#fkjds';
   
    requestaKitFormController.FormDetails(inputString);
    }
    
    public static testmethod void requestAKitMethodwithContact(){
    Account acc = (Account) TestFactory.createSObject(new Account(
                Name = 'testName',
                Account_Type__c = 'Clinical Account US',Qualified__c = true,
                RecordTypeId = '01234000000HoYZ',
                Delivery_Report_Type__c = 'Email',
                BillingCountry = 'US',
                BillingPostalCode = '01234'), true);
    string inputString = 'test;#lastna;#2827262544;#tesbscgsgb@gmail.com;#prfirst;#prlast;#vkdckdfke@gmail.com;#sjdsajddd;#sjdfh;#SA;#CA;#12345;#hfghjdfhj;#hfdshj';
    
    test.starttest();
    TestFactory.createSObject(new Contact(
                LastName = 'Test01',
                NPI_Matched__c = false,
                NPI_Number__c = '2827262544',
                AccountId = acc.Id), true);
    requestaKitFormController.FormDetails(inputString);
    test.stopTest();
    }
    
     
 }