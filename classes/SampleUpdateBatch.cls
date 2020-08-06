public with sharing class SampleUpdateBatch  implements Database.Batchable<SObject>{
    public final String query;

    public SampleUpdateBatch(String query){
        this.query = query;
    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<SObject> scope){
        SampleService.setPreviousSampleDate(scope);
    }

    public void finish(Database.BatchableContext BC){
    }
}