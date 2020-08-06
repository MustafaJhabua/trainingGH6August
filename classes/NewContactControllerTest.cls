@isTest
public class NewContactControllerTest {
    @isTest static void setup() {
        
          Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
  
          User usr = new User(LastName = 'LIVESTON',
                     FirstName='JASON',
                     Alias = 'jliv',
                     Email = 'jason.liveston@asdf.com',
                     Username =Math.random()+'@'+Math.random()+'.test',
                     ProfileId = profileId.id,
                     TimeZoneSidKey = 'GMT',
                     LanguageLocaleKey = 'en_US',
                     EmailEncodingKey = 'UTF-8',
                     LocaleSidKey = 'en_US',
                     Region__c ='National'        
                     );
        insert usr;
        
        Account a = new Account();
        a.name = 'Test data';
        a.Region__c ='National';
        a.Account_Type__c ='Clinical Account US';
        a.BillingStreet	='6445 Main StOPC 24';
        a.BillingCountry='US';
        a.BillingCity='Houston';
        a.BillingState	='TX';
        a.BillingPostalCode='77030';
        insert a;
        
        Account_Integration_Tasks_Master__c ac1 = new Account_Integration_Tasks_Master__c();
        ac1.Name='test';
        ac1.Support_Team_Care_Team_Role__c='Sends the kit';
        insert ac1;
        
        Contact con = new Contact();
        con.lastName ='Test';
        con.AccountId=a.Id;
        con.GRO_Tool__c =True;
        con.Integration_Contact_Type__C ='Physician';
        insert con;
        system.debug(con);
        
        Account_Integration_Tasks_Master__c ac = new Account_Integration_Tasks_Master__c();
        ac.Name='test';
        ac.Support_Team_Care_Team_Role__c='Sends the Kit';
        insert ac;
        
  
        
        Account_Integration_Tasks__c at = new Account_Integration_Tasks__c();
        at.Name=ac.name;
        at.Integration_Question__c=ac.Id;
        at.Physician__c =con.Id;
        insert at;
        
        Affilation__c af = new Affilation__c();
        af.Contact__C =Con.Id;
        af.Account__c=a.Id;
        insert af;
        
        NewContactController.groToolRecords(usr.Id);
        NewContactController.getChildRecords(con.Id);
        NewContactController.getCareTeamMemberAccount(con.Id);
        NewContactController.getCareTeamMemberAccountId(con.Id);
        NewContactController.getIntegrationContactType(con.Id);
                 
    }
    @isTest static void setup1(){
        
        Account a = new Account();
        a.name = 'Test data';
        a.Region__c ='National';
        a.Account_Type__c ='Clinical Account US';
        a.BillingStreet	='6445 Main StOPC 24';
        a.BillingCountry='US';
        a.BillingCity='Houston';
        a.BillingState	='TX';
        a.BillingPostalCode='77030';
        insert a;
        
        Contact con = new Contact();
        con.lastName ='Test';
        con.AccountId=a.Id;
        con.GRO_Tool__c =True;
        con.Integration_Contact_Type__C ='Physician';
        insert con;
        
        Contact con1 = new Contact();
        con1.lastName ='Test';
        con1.AccountId=a.Id;
        con1.GRO_Tool__c =True;
        con1.Integration_Contact_Type__C ='Physician';
        con1.Care_Team_Member_Roles__c ='Educates Patient;Draws the Blood';
        
        
        con1.Care_Team_Member__c=con.Id;
        insert con1;
         
    }
}