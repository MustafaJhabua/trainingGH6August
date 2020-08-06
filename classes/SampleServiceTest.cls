@IsTest(SeeAllData=false)
public with sharing class SampleServiceTest {


    @TestSetup
    public static void setupObjects(){
        AdminTriggerToggle__c toggle = new AdminTriggerToggle__c();
        toggle.BypassSampleUpdateTrigger__c = false;
        insert toggle;

        //Create Account
        Account a1 = (Account) TestFactory.createSObject(new Account(Account_Type__c = 'Clinical Account US'), true);
        //Create Contact
        Contact c1 = (Contact) TestFactory.createSObject(new Contact(AccountId = a1.Id),true);
        //Create Samples
        Guardant_360_Sample__c[] samples = (Guardant_360_Sample__c[]) TestFactory.createSObjectList(new Guardant_360_Sample__c(Contact__c = c1.Id, Account__c = a1.Id),10);
        for (Integer i = 0; i < samples.size(); i++) {
            Guardant_360_Sample__c sample = samples.get(i);
            sample.Date_Received__c = Date.today() - i;
        }
        insert samples;
    }

    
    @IsTest
    public static void testProcessNewSamples(){
            Account a1 = (Account) TestFactory.createSObject(new Account(Account_Type__c = 'Clinical Account US'), true);
             NPI_Records__c np = new NPI_Records__c(name='1234567890',NPI_Number__c='1234567890');
      insert np;

        Contact con = (Contact)TestFactory.createSObject(new Contact(
                LastName = 'Test01',
                NPI_Matched__c = false,
                NPI_Number__c = '1234567890',Actual_NPI__c=np.id,
                AccountId = a1.Id,
                Request_a_Kit_Details__c = 'chandra1112s112,kumar,7657889567,chandra111@gmail.com, younesh,RY,younesh123@gmail.com,practiveEmail,morabadi,ranchi,jharkhand,01234,BREAST CANCER'
        ),true);
                Guardant_360_Sample__c[] samples = (Guardant_360_Sample__c[]) TestFactory.createSObjectList(new Guardant_360_Sample__c(Contact__c = con.Id, Account__c = a1.Id),10);

       test.starttest();
     
       set<id> ss= new set<id>{};
        List<Guardant_360_Sample__c> samples1 = querySamples();
        SampleService.processNewSamples(samples1);
        SampleSelector.querySampleCountByNpi(new set<id>{np.id});
        test.stoptest();
    }

    @IsTest
    public static void testRankSamples(){
        List<Guardant_360_Sample__c> samples = querySamples();
        SampleService.rankSamples(samples);
    }

    @IsTest
    public static void testRankSamples2(){
        List<Guardant_360_Sample__c> samples = querySamples();
        SampleService.rankSamples(new Map<Id,Guardant_360_Sample__c>(samples),new Map<Id,Guardant_360_Sample__c>(samples));
    }

    @IsTest
    public static void testRankSamplesBySinglePhysician(){
        Id contactId = [SELECT Id FROM Contact LIMIT 1].Id;
        SampleService.rankSamplesBySinglePhysician(contactId);
    }
    
     @IsTest
    public static void testRankSamplesBySinglePhysician6(){
    Account a1 = (Account) TestFactory.createSObject(new Account(Account_Type__c = 'Clinical Account US'), true);
        //Create Contact
    Contact c1 = (Contact) TestFactory.createSObject(new Contact(AccountId = a1.Id),true);
    //Create Samples
    LIMS_Project_ID__c   lp= new LIMS_Project_ID__c( LIMS_Project_ID__c ='1234',Sponsor_Account__c =a1.id) ;
   insert lp;
   Test.startTest();
   LIMS_Project_ID__c   lp1= new LIMS_Project_ID__c( LIMS_Project_ID__c ='2134',Sponsor_Account__c =a1.id) ;
   insert lp1;
    Guardant_360_Sample__c sample = new Guardant_360_Sample__c(LIMS_Project_ID__c='1234',Contact__c = c1.Id, Account__c = a1.Id);
  insert sample;
  Guardant_360_Sample__c gs = new Guardant_360_Sample__c(id=sample.id, LIMS_Project_ID__c = '2134');
 
  update gs;
     Test.stopTest();

   
   }

    @IsTest
    public static void testSetPreviousSampleDate(){
        Guardant_360_Sample__c[] samples = Database.query(SampleSelector.querySamplesToSetPreviousSampleDate());
        Test.startTest();
        SampleService.setPreviousSampleDate(samples);
        Test.stopTest();
        samples = [SELECT Id, Date_Received__c, Previous_Date_Received_Contact__c FROM Guardant_360_Sample__c ORDER BY Date_Received__c DESC ];

        System.assertEquals(Date.today()-1, samples[0].Previous_Date_Received_Contact__c);
        delete samples;
        SampleTriggerHandler sampl = new SampleTriggerHandler(true,1);
        sampl.OnBeforeUpdate(new List<Guardant_360_Sample__c>(),new List<Guardant_360_Sample__c>(),new Map<id,Guardant_360_Sample__c>(),new Map<id,Guardant_360_Sample__c>());
        sampl.OnBeforeInsert(new List<Guardant_360_Sample__c>());
        Boolean b = sampl.IsTriggerContext;
        Boolean c =sampl.IsExecuteAnonymousContext;
        Boolean d =sampl.IsWebServiceContext;
        Boolean e =sampl.IsVisualforcePageContext;
    }

    private static List<Guardant_360_Sample__c> querySamples(){
        return [SELECT Id, Contact__c, Patient__c, Test_Count__c, Patient_Test_Count__c FROM Guardant_360_Sample__c];
    }
}