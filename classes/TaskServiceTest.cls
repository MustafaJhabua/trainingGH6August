@IsTest(SeeAllData=false)
public with sharing class TaskServiceTest {

    @TestSetup
    private static void setupObjects() {
        ContactActionsTest.setupObjects();
        Contact c = [SELECT Id FROM Contact LIMIT 1];
        //Need to create enhanced email records as shown https://developer.salesforce.com/docs/atlas.en-us.object_reference.meta/object_reference/sforce_api_objects_emailmessage.htm


    }
    @IsTest
    private static void test_updateLastEmail() {
        //TODO improve this test by simulating an email not a task. Emails will create appropriate task relation records
        Contact c = [SELECT Id,Last_Email_Date__c FROM Contact LIMIT 1];
        System.assertEquals(c.Last_Email_Date__c, null);
        Task t = (Task) TestFactory.createSObject(new Task(WhoId = c.Id,
                Type = 'Outbound Email', ActivityDate = Date.today(),
                Subject = 'E-mail' , Status = 'Completed', TaskSubtype ='Email'), true);
        EmailMessage em = (EmailMessage) TestFactory.createSObject(new EmailMessage(RelatedToId =c.Id ), true);
        System.debug('Task Query: '+ [SELECT Id, WhoId, TaskSubtype FROM Task]);
        //System.debug('Selector Result: '+TaskSelector.selectEmailTasksWithRelations(new Set<Id>{t.Id}));
        //TaskRelation tr = (TaskRelation) TestFactory.createSObject(new TaskRelation(RelationId = c.Id, TaskId = t.Id),true);
        Test.startTest();
        //TaskService.updateLastEmail(new Set<Id>{t.Id});
        Test.stopTest();
        // TaskRelation relation = [SELECT Id FROM TaskRelation LIMIT 1];
        //System.debug('==='+relation);
        //TaskService.updateLastEmail(new Set<Id>{t.Id});

    }
}