trigger AffilationTrigger on Affilation__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
	AdminTriggerToggle__c toggle= AdminTriggerToggle__c.getInstance();
	if(!toggle.Bypass_Affiliation_Trigger__c){
		AffilationTriggerHandler handler = new AffilationTriggerHandler(Trigger.isExecuting, Trigger.size);
		
		if(Trigger.isInsert && Trigger.isBefore){
			handler.OnBeforeInsert(Trigger.new);
		}
		else if(Trigger.isInsert && Trigger.isAfter){
			handler.OnAfterInsert(Trigger.new);
            handler.OnAfterInsert_Map(Trigger.newMap);
			if(!System.isFuture() && !System.isBatch())AffilationTriggerHandler.OnAfterInsertAsync(Trigger.newMap.keySet());
		}
		
		else if(Trigger.isUpdate && Trigger.isBefore){
			handler.OnBeforeUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
		}
		else if(Trigger.isUpdate && Trigger.isAfter){
			handler.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
			if(!System.isFuture() && !System.isBatch())AffilationTriggerHandler.OnAfterUpdateAsync(Trigger.newMap.keySet());
		}
		
		else if(Trigger.isDelete && Trigger.isBefore){
			handler.OnBeforeDelete(Trigger.old, Trigger.oldMap);
		}
		else if(Trigger.isDelete && Trigger.isAfter){
			handler.OnAfterDelete(Trigger.old, Trigger.oldMap);
			if(!System.isFuture() && !System.isBatch())AffilationTriggerHandler.OnAfterDeleteAsync(Trigger.oldMap.keySet());
		}
		
		else if(Trigger.isUnDelete){
			handler.OnUndelete(Trigger.new);	
		}
	}	
}