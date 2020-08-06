@IsTest
public class TestResendFaxTrigger {
    static testmethod void testexecute() {
        List<Account> lstAcc = Test_Data_Factory.createAccounts(1, null);
        insert lstAcc;
        List<Contact> lstContact = Test_Data_Factory.createContacts(lstAcc);
        insert lstContact;

        Guardant_360_Sample__c rep = new Guardant_360_Sample__c(
        	Name ='Test', 
        	Account__c = lstAcc[0].Id, 
        	Contact__c = lstContact[0].Id
        );
        insert rep;

        Attachment att = new Attachment(
        	ParentId = rep.Id,
        	Name = 'Test',
        	Body = Blob.valueOf('Test Attachment Body')
        );
        insert att;

        efaxapp__Sent_Fax__c fax = new efaxapp__Sent_Fax__c(
        	efaxapp__Fax_Number__c = '132456346',
         	efaxapp__Attachment_ID__c = att.Id,
         	efaxapp__Subject__c = 'Test',
         	Guardant_360_Sample__c = rep.Id,
         	efaxapp__Parent_ID__c = rep.Id,
         	efaxapp__Send_Date__c = Datetime.now().addminutes(-5),
         	efaxapp__Sent_Date__c = Datetime.now()
        );
        insert fax;

        system.debug(fax);

        Test.startTest();
        fax.Resend__c = true;
        update fax;      
        Test.stopTest();
        List<Attachment> atts = [Select Id, Name from Attachment];
        for(Attachment a : atts){
        	System.assertNotEquals(att.Id, a.Id);
        }
    }
}