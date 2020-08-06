public with sharing class TerritoryService {

    public static List<Account> updateAccountTerritoryName(List<Account> accounts){
        Map<Id,Account> accountMap = new Map<Id, Account>(accounts);
        Map<Id, TerritoryAttributes> accountTerritoryMap = TerritorySelector.queryTerritoryNameByAccount(accountMap.keySet());
//        System.debug('accountterritoryMap: '+accountTerritoryMap);
        Set<Id> territoryIds = new Set<Id>();
        for(TerritoryAttributes ta:accountTerritoryMap.values()){
            territoryIds.add(ta.territoryId);
        }
        Map<Id,Id> territoryIdUserMap = TerritorySelector.getTerritoryActiveUsers(territoryIds);

        for(Account acc : accounts){
            TerritoryAttributes newTerritoryAttribute = accountTerritoryMap.get(acc.Id);
            if(newTerritoryAttribute == null){
                continue;
            }
            Id territoryUser = territoryIdUserMap.get(newTerritoryAttribute.territoryId);
//            System.debug('Territory Attributes: '+newTerritoryAttribute);
            if(newTerritoryAttribute.territoryName != acc.Territory_Name__c){
                acc.Previous_Territory_Name__c = acc.Territory_Name__c;
                acc.Territory_Name__c = newTerritoryAttribute.territoryName;
            }
            if(newTerritoryAttribute.territoryParentName != null && newTerritoryAttribute.territoryParentName != acc.Territory_Region__c){
                acc.Territory_Region__c = newTerritoryAttribute.territoryParentName;
            }
            if(territoryUser != null && territoryUser != acc.OwnerId){
                acc.OwnerId = territoryUser;
            }
        }
        return accounts;
    }

    public static void updateSaveAccountTerritoryName(List<Account> accounts){
        accounts = updateAccountTerritoryName(accounts);
        Database.SaveResult[] results =  Database.update(accounts,false);
        for (Database.SaveResult saveResult : results) {
            if(!saveResult.success){
//                System.debug(saveResult.getErrors());
            }
        }
    }

    public class TerritoryAttributes{
        public Id territoryId;
        public String territoryName;
        public String territoryParentName;
    }
}