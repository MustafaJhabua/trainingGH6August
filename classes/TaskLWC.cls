public class TaskLWC {
    @AuraEnabled
    public static Task createTask(String subject, String whoId) {
        Task t = new Task();
        t.Subject = subject;
        t.Priority = 'High';
        // t.ActivityDate = System.today()+5;
        t.WhoId = whoId;
        t.OwnerId = UserInfo.getUserId();
        insert t;
        return t;
    }
    @AuraEnabled
    public static Task updateTask(String status, String taskId) {
        Task t = new Task();
        if( taskId != '' && status != '' ) {
            t = [SELECT Id, Subject, Status FROM Task WHERE Id =: taskId];
            t.Status = status;
            update t;
        }
        return t;
    }
}