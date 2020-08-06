public with sharing class TaskSelector {

    //get related Task Relations

    public static List<Task> selectEmailTasksWithRelations(Set<Id> taskIds) {
        List<Task> results = [
                SELECT
                        Id,
                        Subject,
                        TaskSubtype,
                        ActivityDate, (
                        SELECT
                                RelationId, IsWhat
                        FROM TaskRelations
                        WHERE IsWhat = FALSE
                )
                FROM Task
                WHERE Id IN :taskIds
                AND TaskSubtype = 'Email'
                AND (NOT(Subject LIKE '%Pardot%'))
        ];
        return results;
    }

}