/******************************************************************
Author : Paramasivan Arunachalam
Description : This class is written for deleting the track changes which is more than one week old.
              This batch objective is to reduce the data storage in the org.
*******************************************************************/
public with sharing class deleteTrackChangesBatch  implements Database.Batchable<SObject>{
    public String query;

    // this method will query the records which is one week old and passes it to execute method
    public Database.QueryLocator start(Database.BatchableContext BC){
        query = 'select id,createddate from trackchanges__c where  createddate < LAST_N_DAYS:8';
        if(Test.isRunningTest()){
        query = 'select id,createddate from trackchanges__c';
        }
        return Database.getQueryLocator(query);
    }
    // This method will directly delete the scope 
    public void execute(Database.BatchableContext BC, List<SObject> scope){
        delete scope;
    }

    public void finish(Database.BatchableContext BC){
    }
}