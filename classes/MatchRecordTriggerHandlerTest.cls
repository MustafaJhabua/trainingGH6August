@IsTest
private class MatchRecordTriggerHandlerTest {
    static testMethod void setSampleIdTest(){
        Match_Record__c mr = new Match_Record__c();
        List <Match_Record__c> mrList = new List <Match_Record__c>();
        
        Account acc = (Account)TestFactory.createSObject(new Account(),true);
        Contact con = (Contact)TestFactory.createSObject(new Contact(AccountId = acc.Id),true);
        TestFactory.createSObject(new Guardant_360_Sample__c(
                Name = 'name',
                Contact__c = con.Id,
                Account__c = acc.Id),true);
        
        mr.Name = 'name';
        mr.Match_ID__c = 'name';
        mr.Portal_Sample_ID__c = 'sample';
        mr.Last_Match_API_Update__c = System.now();
        
        insert mr;
        mrList.add(mr);
        
        POD__c pod = new POD__c();
        pod.Match_Record__c = mr.Id;
        insert pod;
        

        
        mr.Referred__c = true;
        mr.Permission_to_Connect_with_Pharma__c = true;
        mr.Client_Notes__c = 'client notes';
        mr.Guardant_Notes__c = 'guardant notes';
        mr.Enrollment_Status__c = 'New';
        mr.Match_Priority__c = 'High';
        mr.Match_Status__c = 'Pending';
        mr.Show_to_Customer__c = true;
        mr.Date_of_1st_Contact__c = System.now();
        mr.Date_of_Last_Contact__c = System.now();
        mr.Date_Enrolled__c = System.now();
        mr.Date_Ineligible__c = System.now();
        mr.Date_Referred__c = System.now();
        mr.Date_of_Failed_Screening__c = System.now();
        
        update mr;
        
        mr.Referred__c = false;
        mr.Permission_to_Connect_with_Pharma__c = false;
        mr.Client_Notes__c = 'client notes2';
        mr.Guardant_Notes__c = 'guardant notes2';
        mr.Enrollment_Status__c = 'Closed';
        mr.Match_Priority__c = 'Low';
        mr.Match_Status__c = 'Accepted';
        mr.Show_to_Customer__c = false;
        mr.Date_of_1st_Contact__c = System.now()+1;
        mr.Date_of_Last_Contact__c = System.now()+1;
        mr.Date_Enrolled__c = System.now()+1;
        mr.Date_Ineligible__c = System.now()+1;
        mr.Date_Referred__c = System.now()+1;
        mr.Date_of_Failed_Screening__c = System.now()+1;
        mr.Send_POD__c = true;
        mr.Custom_Signature__c = 'Rick Lanman, MD';
        mr.X1st_Paragraph__c = 'These are words for a paragraph';
        mr.Enrollment_Sub_Status__c = 'Ineligible';
        mr.Sub_Status_Reason__c = 'Death';
        
        
        update mr;
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('callout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);

    }

}