public with sharing class MarketableContactBatchScheduler implements Schedulable{

public void execute (SchedulableContext sc){
    MarketableContactBatch b = new MarketableContactBatch();
    Database.executeBatch(b,Integer.valueOf(System.Label.MarketableContactBatchSize));
}

}