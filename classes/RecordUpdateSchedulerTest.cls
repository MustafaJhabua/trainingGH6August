@IsTest
private class RecordUpdateSchedulerTest {
    @IsTest
    static void test_executeScheduler() {
        Test.startTest();
        String cronExp = '0 0 0 1 1 ? 2025';
        String jobId = System.schedule('testRecordUpdateScheduler', cronExp, new RecordUpdateScheduler());
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