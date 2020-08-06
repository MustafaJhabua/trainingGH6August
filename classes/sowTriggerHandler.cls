public class sowTriggerHandler{
    public static void onAfterUpdate(List<LIMS_Project_ID__c> newProject,map<id,LIMS_Project_ID__c> oldMap){
    sowService.populatingSOWOnSamples(newProject,oldMap);
    }
    }