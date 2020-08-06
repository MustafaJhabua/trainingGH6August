@IsTest(SeeAllData=false)
public with sharing class SampleUpdateBatchTest {

    @TestSetup
    public static void setupObjects() {
        SampleServiceTest.setupObjects();
    }

    @IsTest
    public static void testBatch() {
        SampleUpdateBatch b = new SampleUpdateBatch(SampleSelector.querySamplesToSetPreviousSampleDate());
        Database.executeBatch(b,50);
    }

    @IsTest
    private static void testScheduler() {
        Test.startTest();
        String cronExp = '0 0 0 1 1 ? 2025';
        String jobId = System.schedule('testSampleUpdateScheduler', cronExp, new SampleUpdateBatchScheduler());
        CronTrigger ct = [
                SELECT Id, CronExpression, TimesTriggered, NextFireTime
                FROM CronTrigger
                WHERE Id = :jobId
        ];
        System.assertEquals(cronExp, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        System.assertEquals('2025-01-01 00:00:00', String.valueOf(ct.NextFireTime));
        Test.stopTest();
    }
}