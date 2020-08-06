trigger TaskTrigger on Task (after delete, after insert, after undelete, after update, before delete, before insert, before update) {

    TaskTriggerHandler handler = new TaskTriggerHandler(Trigger.isExecuting, Trigger.size);

    if (Trigger.isInsert && Trigger.isBefore) {
        handler.OnBeforeInsert(Trigger.new);
    } else if (Trigger.isInsert && Trigger.isAfter) {
        handler.OnAfterInsert(Trigger.newMap);
    }

}