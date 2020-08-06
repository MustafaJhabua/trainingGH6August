@isTest
  public class sowServiceTest{
  public static testmethod void sowserviceMethod1(){
   Account a1 = (Account) TestFactory.createSObject(new Account(Account_Type__c = 'Clinical Account US'), true);
        //Create Contact
    Contact c1 = (Contact) TestFactory.createSObject(new Contact(AccountId = a1.Id),true);
    //Create Samples
    Guardant_360_Sample__c[] samples = (Guardant_360_Sample__c[]) TestFactory.createSObjectList(new Guardant_360_Sample__c(LIMS_Project_ID__c='1234',Contact__c = c1.Id, Account__c = a1.Id),10);
  
   LIMS_Project_ID__c   lp= new LIMS_Project_ID__c( LIMS_Project_ID__c ='1234',Sponsor_Account__c =a1.id) ;
   insert lp;
   
   update lp;
  }
  }