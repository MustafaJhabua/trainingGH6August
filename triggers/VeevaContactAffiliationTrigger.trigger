trigger VeevaContactAffiliationTrigger on Veeva_Contact_Affiliation__c (before insert) {
    AdminTriggerToggle__c toggle= AdminTriggerToggle__c.getInstance();
    if(!toggle.Bypass_Veeva_Contact_Affiliation_Trigger__c){
        VeevaContactAffiliationTriggerHandler handler = new VeevaContactAffiliationTriggerHandler(Trigger.isExecuting, Trigger.size);
        
        if(Trigger.isInsert && Trigger.isBefore){
            handler.OnBeforeInsert(Trigger.new);
        }
        else if(Trigger.isInsert && Trigger.isAfter){
            
            
        }
        
        else if(Trigger.isUpdate && Trigger.isBefore){
            
        }
        else if(Trigger.isUpdate && Trigger.isAfter){
            
            
        }
        
        else if(Trigger.isDelete && Trigger.isBefore){
            
        }
        else if(Trigger.isDelete && Trigger.isAfter){
            
            
        }
        
        else if(Trigger.isUnDelete){
            
        }
    }	
}