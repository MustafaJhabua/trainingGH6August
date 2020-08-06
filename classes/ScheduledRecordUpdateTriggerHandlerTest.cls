@IsTest
private class ScheduledRecordUpdateTriggerHandlerTest {
    private static final String CRON_EXP = '0 0 0 1 1 ? 2025';

    @TestSetup
    public static void SetupObjects() {
        Scheduled_Record_Update__c[] records = (Scheduled_Record_Update__c[])TestFactory.createSObjectList(
                new Scheduled_Record_Update__c(
                        Name = 'Test Record',
                        CRON_Expression__c = CRON_EXP,
                        Batch_Size__c = 100,
                        SOQL_Query__c = 'SELECT Id, Name FROM Account LIMIT 1',
                        Write_To_Field__c = 'Name',
                        Write_Text__c = 'Test'
                ),1, true);
    }

    @IsTest
    public static void testUpdateTrigger() {
        Scheduled_Record_Update__c record = [SELECT Id, Write_Text__c FROM Scheduled_Record_Update__c LIMIT 1];
        record.Write_Text__c = 'Test Update';
        update record;
    }

    @IsTest
    public static void testDeleteTrigger() {
        Scheduled_Record_Update__c record = [SELECT Id, Write_Text__c FROM Scheduled_Record_Update__c LIMIT 1];
        delete record;
    }


}