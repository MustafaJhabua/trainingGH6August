trigger MatchRecordTrigger on Match_Record__c(before update, before insert, after delete, after update) {
    if (Trigger.isBefore) {
        //Code to execute before update
        if (!MatchRecordTriggerHelper.inFutureContext) {
            if (Trigger.isUpdate) {
                MatchRecordTriggerHandler.onBeforeUpdate(Trigger.new, Trigger.oldMap);
            }
        }
        //Code to execute before insert
        if (Trigger.isInsert) {
            //MatchRecordTriggerHandler.setSampleID(Trigger.new);
        }
    } else if (Trigger.isAfter) {
        if(Trigger.isUpdate){
            MatchRecordTriggerHandler.onAfterUpdate(Trigger.new);
        }

        //Code to execute after delete
        if (Trigger.isDelete) {
            MatchCountFlow.callFlow(Trigger.old);
            MatchRecordTriggerHandler.onAfterDelete(Trigger.old);
        }
    }
}