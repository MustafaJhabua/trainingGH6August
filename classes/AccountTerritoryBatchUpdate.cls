public class AccountTerritoryBatchUpdate implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'select id,Territory_Name__c,Territory_Region__c,BillingPostalCode from account where Account_Type__c =\'Clinical Account US\' and BillingPostalCode != null';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Account> accounts) {
    map<string,Zip_Code__c> zipandTerritoryMap = new map<string,Zip_Code__c>();
    map<string,account> zipAccountMap = new map<string,account>();
    List<account> accList = new List<account>();
    List<account> updateaccList = new List<account>();
    set<string> zipSet = new set<string>();

        for(account acc:accounts){
        accList.add(acc);
        zipAccountMap.put(acc.BillingPostalCode,acc);
        }
        
        if(zipAccountMap.size() > 0){
         zipSet = zipAccountMap.keyset();
        for(Zip_Code__c zip :[select id,Territory__c,Region__c,name from Zip_Code__c where name in:zipSet]){
        zipandTerritoryMap.put(zip.name,zip);
        }
        }
        
        for(account ac : accList){
        if(zipandTerritoryMap.get(ac.BillingPostalCode) != null){
         ac.Territory_Name__c   = zipandTerritoryMap.get(ac.BillingPostalCode).Territory__c;
         ac.Territory_Region__c = zipandTerritoryMap.get(ac.BillingPostalCode).Region__c;
         updateaccList.add(ac);
         }
        }
        
        if(updateaccList.size() > 0){
        update updateaccList;
        }
    }
    public void finish(Database.BatchableContext BC) {
    }

}