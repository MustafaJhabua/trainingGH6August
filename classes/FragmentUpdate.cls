public with sharing class FragmentUpdate implements Queueable {

    private List<SObject> records;
    private Integer fragmentSize;

    public FragmentUpdate(List<SObject> records, Integer fragmentSize) {
        this.records = records;
        this.fragmentSize = fragmentSize;
        Log.debug('Records to save: '+ String.valueOf(records.size()));
    }

    public void execute(QueueableContext context) {
        List<SObject> recordsToSave = new List<SObject>();
        for (Integer i = 0; i < fragmentSize; i++) {
            if(records.size() > 0) {
                recordsToSave.add(records[0]);
                records.remove(0);
            }
        }

        if(recordsToSave.size()>0){
            System.Database.update(recordsToSave);
        }

        if(records.size()>0 && !Test.isRunningTest()){
            System.enqueueJob(new FragmentUpdate(records,fragmentSize));
        }
    }
}