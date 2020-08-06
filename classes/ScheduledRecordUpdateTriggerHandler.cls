public with sharing class ScheduledRecordUpdateTriggerHandler {
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;

    public ScheduledRecordUpdateTriggerHandler(boolean isExecuting, integer size) {
        m_isExecuting = isExecuting;
        BatchSize = size;
    }

    public void OnBeforeInsert(Scheduled_Record_Update__c[] newRecords) {
        RecordUpdateService.scheduleUpdate(newRecords);
    }

    public void OnAfterInsert(Scheduled_Record_Update__c[] newRecords) {

    }

    public void OnBeforeUpdate(Scheduled_Record_Update__c[] oldRecords, Scheduled_Record_Update__c[] updatedRecords, Map<ID, Scheduled_Record_Update__c> oldMap, Map<ID, Scheduled_Record_Update__c> newMap) {
        RecordUpdateService.deleteSchedule(updatedRecords);
        RecordUpdateService.scheduleUpdate(updatedRecords);
    }

    public void OnAfterUpdate(Scheduled_Record_Update__c[] oldRecords, Scheduled_Record_Update__c[] updatedRecords, Map<ID, Scheduled_Record_Update__c> oldMap, Map<ID, Scheduled_Record_Update__c> newMap) {

    }
    public void OnBeforeDelete(Scheduled_Record_Update__c[] recordsToDelete, Map<ID, Scheduled_Record_Update__c> recordMap) {
        RecordUpdateService.deleteSchedule(recordsToDelete);
    }

    public void OnAfterDelete(Scheduled_Record_Update__c[] deletedRecords, Map<ID, Scheduled_Record_Update__c> recordMap) {

    }


    public void OnUndelete(Scheduled_Record_Update__c[] restoredRecords) {

    }

}