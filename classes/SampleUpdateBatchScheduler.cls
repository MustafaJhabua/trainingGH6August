public with sharing class SampleUpdateBatchScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {
        SampleUpdateBatch b = new SampleUpdateBatch(SampleSelector.querySamplesToSetPreviousSampleDate());
        Database.executeBatch(b, Integer.valueOf(System.Label.SampleUpdateBatchSize));
    }

}