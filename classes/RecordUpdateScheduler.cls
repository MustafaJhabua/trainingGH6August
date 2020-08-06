global class RecordUpdateScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {
        String jobId = sc.getTriggerId();
        jobId = jobId.substring(0, jobId.length() - 3);
        system.debug('===JobId: ' + jobId);
        List<Scheduled_Record_Update__c> scheduledProcesses = [
                SELECT
                        SOQL_Query__c,
                        Write_Text__c,
                        Write_To_Field__c,
                        Batch_Size__c
                FROM Scheduled_Record_Update__c
                WHERE JobId__c = :jobId
                LIMIT 1
        ];
        Scheduled_Record_Update__c scheduledProcess = (scheduledProcesses.size() == 1) ? scheduledProcesses.get(0) : null;
        if (scheduledProcess == null) {
            return ;
        }
        Integer batchSize = scheduledProcess.Batch_Size__c != null ? Integer.valueOf(scheduledProcess.Batch_Size__c) : 200;
        Database.executeBatch(new RecordUpdateBatch(
                scheduledProcess.SOQL_Query__c,
                scheduledProcess.Write_To_Field__c,
                scheduledProcess.Write_Text__c), batchSize);
    }
}