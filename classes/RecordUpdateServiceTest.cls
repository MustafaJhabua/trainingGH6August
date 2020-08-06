@IsTest
private class RecordUpdateServiceTest {
    private static final String CRON_EXP = '0 0 0 1 1 ? 2025';

    @IsTest
    private static void test_ScheduleUpdate() {

        Scheduled_Record_Update__c[] schedRecords = (Scheduled_Record_Update__c[])TestFactory.createSObjectList(
                new Scheduled_Record_Update__c(
                        Name = 'Test Record',
                        CRON_Expression__c = CRON_EXP
                ),1);
        RecordUpdateService.scheduleUpdate(schedRecords);

    }
    @IsTest
    private static void test_DeleteSchedule(){
        Test.startTest();
        test_ScheduleUpdate();

        CronTrigger ct = [
                SELECT Id
                FROM CronTrigger
                WHERE CronExpression = :CRON_EXP
                LIMIT 1
        ];

        Scheduled_Record_Update__c[] schedRecords = (Scheduled_Record_Update__c[])TestFactory.createSObjectList(
                new Scheduled_Record_Update__c(
                        Name = 'Test Record',
                        CRON_Expression__c = CRON_EXP,
                        JobId__c = ct.Id
                ),1);

        RecordUpdateService.deleteSchedule(schedRecords);
        Test.stopTest();

    }

}