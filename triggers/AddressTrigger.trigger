trigger AddressTrigger on Address__c (before insert) {
    AdminTriggerToggle__c toggle= AdminTriggerToggle__c.getInstance();
    if(!toggle.Bypass_Address_Trigger__c){
        AddressTriggerHandler handler = new AddressTriggerHandler(Trigger.isExecuting, Trigger.size);
        
        if(Trigger.isInsert && Trigger.isBefore){
            handler.OnBeforeInsert(Trigger.new);
        }
    }
}