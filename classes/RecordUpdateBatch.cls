global with sharing class RecordUpdateBatch implements Database.Batchable<SObject>{
    global final String query;
    global final String fieldName;
    global String fieldValue;

    global RecordUpdateBatch(String query, String fieldName, String fieldValue){
        this.query = query;
        this.fieldName = fieldName;
        this.fieldValue = fieldValue;
    }

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope){
        for(SObject s : scope){
            if(fieldValue == 'Now()'){
                fieldValue = String.valueOf(Datetime.now());
            }
            s.put(fieldName, fieldValue);
            System.debug('Record To Update: '+s);
        }
        List<Database.SaveResult> srList = Database.update(scope, false);
        for (Database.SaveResult sr : srList){
            if(!sr.isSuccess()){
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                }
            }
        }
    }

    global void finish(Database.BatchableContext BC){
    }

}