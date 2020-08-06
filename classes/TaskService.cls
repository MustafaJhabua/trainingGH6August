public with sharing class TaskService {

    public static void createYuzuLink(List<Task> outreachActivities) {
        for (Task task : outreachActivities) {
            if (task.Subject == 'Outreach Activity' && task.MD_Granted_Permission_to_Connect__c == true && task.Trial_Site__c != null) {
                callYuzuService(task.WhatId);
            }
        }
    }

    @Future(Callout=true)
    public static void callYuzuService(Id matchRecordId) {
        MatchRecordService service = new MatchRecordService();
        service.mRecord = MatchRecordSelector.queryMatchRecordForYuzu(matchRecordId);
        service.assignStudyPageURL();
    }

    public static void updateLastEmail(Set<Id> taskIdsInserted) {
        List<Task> emailTasksWithRelations = TaskSelector.selectEmailTasksWithRelations(taskIdsInserted);
        Map<Id, Date> contactIdEmailDate = new Map<Id, Date>();
        //System.debug('emailTasksWithRelations'+emailTasksWithRelations);
        for (Task task : emailTasksWithRelations) {
            for (TaskRelation relation : task.TaskRelations) {
                contactIdEmailDate.put(relation.RelationId, task.ActivityDate);
            }
        }
        if (contactIdEmailDate.size() > 0) {
            ContactService.updateContactEmailDate(contactIdEmailDate);
        }
    }
}