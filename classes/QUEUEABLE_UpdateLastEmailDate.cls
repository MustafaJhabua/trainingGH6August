public with sharing class QUEUEABLE_UpdateLastEmailDate implements Queueable{
    public Set<Id> taskIds = new Set<Id>();

    public QUEUEABLE_UpdateLastEmailDate(Set<Id> taskIds){
        this.taskIds = taskIds;
    }

    public void execute(QueueableContext context){
        TaskService.updateLastEmail(taskIds);
    }

}