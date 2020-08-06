global class ContactVeevaReformatBatch implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
        //String newSearchText = 'v_';
        String val='\'%v_%\'';
        String query = 'Select Veeva_ID__c from Contact where Veeva_ID__c!= null and Veeva_ID__c like '+val+'';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> scope){
        List<Contact> conList = new List<Contact>();
        for(Contact con : scope){
            con.Veeva_ID__c = con.Veeva_ID__c.replace('v_','');
            System.debug('con.Veeva_ID__c - '+ con.Veeva_ID__c);
            conList.add(con);
        }
        if(conList != null && conList.size() > 0){
            update conList;
        }
    }
    
    global void finish(Database.BatchableContext info){
    }//global void finish loop
}