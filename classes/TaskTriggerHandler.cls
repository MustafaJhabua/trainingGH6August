public with sharing class TaskTriggerHandler {
    private Boolean m_isExecuting = false;
    private Integer BatchSize = 0;

    public TaskTriggerHandler(Boolean isExecuting, Integer size) {
        m_isExecuting = isExecuting;
        BatchSize = size;
    }

    public void OnBeforeInsert(Task[] newRecords) {
        TaskService.createYuzuLink(newRecords);
    }

    public void OnAfterInsert(Map<Id,Task> newMap) {
        //TaskService.updateLastEmail(newMap.keySet());
        if(!System.isQueueable() && Limits.getQueueableJobs() == 0){
            System.enqueueJob(new QUEUEABLE_UpdateLastEmailDate(newMap.keySet()));
        }
    }

    public Boolean IsTriggerContext {
        get {
            return m_isExecuting;
        }
    }
}