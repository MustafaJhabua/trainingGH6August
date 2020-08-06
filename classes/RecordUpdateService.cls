public with sharing class RecordUpdateService {

    public static void scheduleUpdate(List<Scheduled_Record_Update__c> newRecords) {
        for (Scheduled_Record_Update__c scheduledRecordUpdate : newRecords) {
            String jobId = System.schedule(scheduledRecordUpdate.Name,
                    scheduledRecordUpdate.CRON_Expression__c,
                    new RecordUpdateScheduler());
            scheduledRecordUpdate.JobId__c = jobId;
        }
    }
    public static void deleteSchedule(List<Scheduled_Record_Update__c> records) {
        for (Scheduled_Record_Update__c scheduledRecordUpdate : records) {
            try {
                System.debug('===JobId to Abort: '+ scheduledRecordUpdate.JobId__c);
                System.abortJob(scheduledRecordUpdate.JobId__c);
            } catch (Exception e) {
                system.debug('Error Deleting Job: '+ e);
            }
            if (!Trigger.isExecuting || !Trigger.isDelete) {
                scheduledRecordUpdate.JobId__c = null;
            }

        }
    }
}