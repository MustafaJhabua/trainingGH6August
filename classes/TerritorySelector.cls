public with sharing class TerritorySelector {

    public static Map<Id, TerritoryService.TerritoryAttributes> queryTerritoryNameByAccount(Set<Id> accountIds) {
        Map<Id, TerritoryService.TerritoryAttributes> results = new Map<Id, TerritoryService.TerritoryAttributes>();
        for (ObjectTerritory2Association record : [
                SELECT ObjectId, Territory2.Name, Territory2.ParentTerritory2.Name, Territory2Id
                FROM ObjectTerritory2Association
                WHERE ObjectId IN :accountIds
                AND Territory2.Territory2Model.State = 'Active'
                ORDER BY LastModifiedDate ASC, Territory2.ParentTerritory2Id ASC
        ]) {
            TerritoryService.TerritoryAttributes ta = new TerritoryService.TerritoryAttributes();
            ta.territoryName = record.Territory2.Name;
            ta.territoryParentName = record.Territory2.ParentTerritory2.Name;
            ta.territoryId = record.Territory2Id;
            results.put(record.ObjectId, ta);
        }
//        System.debug('Selector Results: ' + results);
        return results;
    }

    public static Map<Id, Id> getTerritoryActiveUsers(Set<Id> territoryIds) {
        Map<Id, Id> result = new Map<Id, Id>();

        for (UserTerritory2Association record : [
                SELECT Territory2Id, UserId
                FROM UserTerritory2Association
                WHERE Territory2Id IN :territoryIds
                AND IsActive = TRUE
        ]) {
            result.put(record.Territory2Id,record.UserId);
        }
//        System.debug('territoryUserResult'+result);
        return result;
    }
}