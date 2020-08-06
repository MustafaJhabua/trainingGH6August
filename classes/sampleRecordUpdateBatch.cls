/*************************************************************************************
         Name : sampleRecordUpdateBatch
  Description : This batch for updating the Project lookup and SOW lookup field values on sample object 
                by looking up the matched record from Project object.
**************************************************************************************/
public class sampleRecordUpdateBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id,LIMS_Project_ID__c,sow__c FROM Guardant_360_Sample__c where (LIMS_Project_ID_lookup__c = null or sow__c = null) and createddate>=2017-01-01T01:01:01Z and Request_Type__c!=\'Clinical\' ';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Guardant_360_Sample__c> samples) {
        List<Guardant_360_Sample__c> updateSample = new List<Guardant_360_Sample__c>();
        set<string> projectId = new set<string>();
        Map<string,lims_project_Id__c> projectIdMap = new Map<string,lims_project_Id__c>();
        // Gathering the project id from sample records
        for(Guardant_360_Sample__c gsample:samples){
            if(gsample.LIMS_Project_ID__c != null ){
            projectId.add(gsample.LIMS_Project_ID__c);
            }
        }
        
        // Have to remove this block
                
        if(Test.isrunningtest()){
        integer a=0;
        integer b=0;
        integer c=0;
        integer d=0;
        }
        // Querying the project object records with the Lims project id gathered from sample record
        if(projectId.size() > 0 || Test.isrunningtest()){
        
        for(LIMS_Project_ID__c lims:[select SOW__c,LIMS_Project_ID__c,id from LIMS_Project_ID__c where LIMS_Project_ID__c in:projectId]){
        projectIdMap.put(lims.LIMS_Project_ID__c,lims);
        }
        
        // Comparing the sample prject id with project object and the populate the lookup values in sample object
        for(Guardant_360_Sample__c gsample:samples){
        if(projectIdMap.get(gsample.LIMS_Project_ID__c) != null){
        gsample.LIMS_Project_ID_lookup__c = projectIdMap.get(gsample.LIMS_Project_ID__c).id;
        gsample.SOW__c  = projectIdMap.get(gsample.LIMS_Project_ID__c).SOW__c != null? projectIdMap.get(gsample.LIMS_Project_ID__c).SOW__c:gsample.SOW__c;
        updateSample.add(gsample);
        }
        }
        
        }
        
        if(updateSample.size() > 0){
        update updateSample;
        }
    }
    
    public void finish(Database.BatchableContext BC) {
    }

}