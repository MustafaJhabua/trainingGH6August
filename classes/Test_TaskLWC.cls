@IsTest
private class Test_TaskLWC {
	@IsTest
    static void testSetup() {
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
        System.debug('Con>'+con);
        
        Task t = new Task();
        t.Subject = 'Test Task Subject';
        t.Priority = 'High';
        t.WhoId = con.Id;
        t.OwnerId = UserInfo.getUserId();
        insert t;
        
        Test.startTest();
        TaskLWC.createTask('Test Subject', con.Id);
        TaskLWC.updateTask('Completed', t.Id);
        test.stopTest();
    }
}