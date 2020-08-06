global class AccountVeevaReformatBatch implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
        //String newSearchText = 'v_';
        String val='\'%v_%\'';
        String query = 'Select Veeva_ID__c from account where Veeva_ID__c!= null and Veeva_ID__c like '+val+'';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope){
        List<Account> acclist = new List<Account>();
        for(account acc:scope){
            acc.Veeva_ID__c = acc.Veeva_ID__c.replace('v_','');
            System.debug('acc.Veeva_ID__c - '+ acc.Veeva_ID__c);
            acclist.add(acc);
        }
        if(acclist != null && acclist.size() > 0){
            update acclist;
        }
    }
    
    global void finish(Database.BatchableContext info){
    }//global void finish loop
}