/****************************************************************
   Modification log
   
   Modified by     Date                  Description       
   
   Siva            March 8,2019           Added code for including workflow rule into trigger
******************************************************************/

trigger SampleUpdateTrigger on Guardant_360_Sample__c (before insert, before update, after insert, after update,after delete) {
AdminTriggerToggle__c toggle= AdminTriggerToggle__c.getInstance();
    //if(AvoidRecursion.isFirstRun()) {
            SampleTriggerHandler handler = new SampleTriggerHandler(Trigger.isExecuting, Trigger.size);

        if (Trigger.isAfter && Trigger.isInsert && !(toggle.BypassSampleUpdateTrigger__c)) {
            System.debug('===After Insert');
            SampleService.processNewSamples(Trigger.new);
            handler.OnAfterInsert(Trigger.new);
            //SampleService.rankSamples(Trigger.new);
        }
       else if (Trigger.isAfter && Trigger.isUpdate && AvoidRecursion.isFirstRun() && !(toggle.BypassSampleUpdateTrigger__c)) {
            System.debug('===After Update');
            if(!System.isQueueable()){//Don't re-run this if the update is already part of a queueable process
                SampleService.rankSamples(Trigger.oldMap, Trigger.newMap);
            }
            handler.OnAfterUpdate(trigger.old,trigger.new,Trigger.oldMap, Trigger.newMap);
        }
        
       else if (Trigger.isAfter && Trigger.isDelete){
        handler.OnAfterDelete(trigger.old,Trigger.oldMap);
        }
        // Added by siva for including the workflow rules into triggers
       /* if(Trigger.isBefore && Trigger.isInsert) {
            SampleService.populateFieldValues(Trigger.new);
        } */
        
        if(Trigger.isBefore) {
        SampleService.populateProjectId(Trigger.new,Trigger.oldmap);
        }
    //}
}