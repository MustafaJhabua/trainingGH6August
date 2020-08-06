@IsTest(SeeAllData=false)
public with sharing class MarketableContactBatchTest {

    @TestSetup
    public static void setupObjects() {
        ContactActionsTest.SetupObjects();
        Contact c = [SELECT Id FROM Contact LIMIT 1];
        c.Contact_Role__c = 'Surgical Oncologist';
        c.Email = 'test@sample.com';
        update c;
        // c.Contact_Role__c = 'Surgical Oncologist';
       // c.Email = '';
       // update c;
    }

    @IsTest
    public static void testBatch(){
    string recordtypeidval = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Commercial Account').getRecordTypeId();
        Account a1 = new Account(Account_Type__c = 'Clinical Account US',name='test',recordtypeId=recordtypeidval);
        insert a1;
        contact c= new contact();
        c.lastName ='test';
        c.Contact_Role__c = 'Surgical Oncologist';
        c.Email = '';
        c.Marketable_User__c = TRUE;
        c.accountid=a1.id;
        insert c;
        MarketableContactBatch b = new MarketableContactBatch();
        Database.executeBatch(b,50);
    }
     @IsTest
    public static void testContactService(){
    List<contact> csList = new List<contact>();
    string recordtypeidval = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Commercial Account').getRecordTypeId();
        Account a1 = new Account(Account_Type__c = 'Clinical Trial Account',name='test',recordtypeId=recordtypeidval);
        insert a1;
        NPI_Records__c  np = new NPI_Records__c(Last_Name__c='hdhhds',NPI_Number__c='122222233');
        
        insert np;
        contact c= new contact();
        c.lastName ='test';
        c.Contact_Role__c = 'Surgical Oncologist';
        c.Email = '';
        c.accountid=a1.id;
        c.Marketable_User__c = TRUE;
        c.actual_npi__c=np.id;
        insert c;
        csList.add(c);
        test.startTest();
       
       ContactService cs= new  ContactService();
       cs.markContactMarketable(csList);
       test.stoptest();
    }
     
    @IsTest
    public static void testContactServicesample(){
    List<contact> csList = new List<contact>();
    string recordtypeidval = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Commercial Account').getRecordTypeId();
        Account a1 = new Account(Account_Type__c = 'Clinical Account US',name='test',recordtypeId=recordtypeidval);
        insert a1;
        NPI_Records__c  np = new NPI_Records__c(Last_Name__c='hdhhds',NPI_Number__c='122222233');
        
        insert np;
        contact c= new contact();
        c.lastName ='test';
        c.Contact_Role__c = 'Surgical Oncologist';
        c.Email = 'test@gmail.com';
        c.accountid=a1.id;
        c.actual_npi__c=np.id;
        c.Marketable_User__c = TRUE;
        c.Unqualified_by_CS__c = true;
        insert c;
        Guardant_360_Sample__c gh=new Guardant_360_Sample__c(name='Ass900',Account__c=a1.id,Contact__c=c.id);
        insert gh;
        csList.add(c);
        test.starttest();
        ContactService cs= new  ContactService();
       cs.markContactMarketable(csList);
       test.stoptest();
       }
        
        
    @IsTest
    public static void testContactService1(){
    List<contact> csList = new List<contact>();
    string recordtypeidval = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Commercial Account').getRecordTypeId();
        Account a1 = new Account(Account_Type__c = 'Clinical Account US',name='test',recordtypeId=recordtypeidval);
        insert a1;
        NPI_Records__c  np = new NPI_Records__c(Last_Name__c='hdhhds',NPI_Number__c='122222233');
        
        insert np;
        contact c= new contact();
        c.lastName ='test';
        c.Contact_Role__c = 'Surgical Oncologist';
        c.Email = 'asdsaf@gmail.com';
        c.accountid=a1.id;
        c.actual_npi__c=np.id;
        c.Marketable_User__c = TRUE;
        insert c;
        Guardant_360_Sample__c gh=new Guardant_360_Sample__c(name='Ass900',Account__c=a1.id,Contact__c=c.id);
        insert gh;
        
        csList.add(c);
        test.startTest();
        contact con= new contact();
        con.lastName ='test';
        con.Contact_Role__c = 'Cytologist/Cytotechnologist';
        con.Email = 'asdsaf@gmail.com';
        con.accountid=a1.id;
        con.actual_npi__c=np.id;
        con.Marketable_User__c = TRUE;
        insert con;
        csList.add(con);
       ContactService cs= new  ContactService();
       cs.markContactMarketable(csList);
       ContactService.checkIfQualifiedRole(con);
       map<id,date> cMap=new map<id,Date>();
       cMap.put(con.id,Date.today());
       ContactService.updateContactEmailDate(cMap);
       test.stoptest();
    }
}