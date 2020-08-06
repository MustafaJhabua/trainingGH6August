trigger ProjectTrigger on LIMS_Project_ID__c (after update) {
if(Trigger.isAfter && Trigger.isUpdate){
sowTriggerHandler.onAfterUpdate(Trigger.new,Trigger.oldMap);
}
}