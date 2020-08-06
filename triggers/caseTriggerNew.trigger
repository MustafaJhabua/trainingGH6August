trigger caseTriggerNew on Case (After Insert,After Update,After Delete) {

  If(Trigger.isInsert && Trigger.isAfter){
  caseHandler.OnAfterInsert(Trigger.new);
  }
  
  If(Trigger.isUpdate && Trigger.isAfter){
  caseHandler.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
  }
  
  If(Trigger.isDelete && Trigger.isAfter){
  caseHandler.OnAfterDelete(Trigger.old, Trigger.oldMap);
  }
  
}