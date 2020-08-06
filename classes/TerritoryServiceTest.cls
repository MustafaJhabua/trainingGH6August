@IsTest(SeeAllData=false)
public with sharing class TerritoryServiceTest {

    @TestSetup
    private static void SetupObjects() {
        Territory2Model tModel = [SELECT Id FROM Territory2Model WHERE State = 'Active' LIMIT 1];
        Territory2Type tType = [SELECT Id, DeveloperName FROM Territory2Type LIMIT 1];
        TestFactory.createSObject(new Territory2(
                DeveloperName = 'TestTerritory',
                Name = 'Test Territory',
                Territory2ModelId = tModel.Id,
                Territory2TypeId = tType.Id),true);
    }
    @IsTest
    private static void testTerritoryNameUpdate() {
        //Create Account
        Account acc = (Account) TestFactory.createSObject(new Account(), true);
        Id territoryId = [SELECT Id FROM Territory2 WHERE DeveloperName = 'TestTerritory' LIMIT 1].Id;
        TestFactory.createSObject(new ObjectTerritory2Association(ObjectId = acc.Id, Territory2Id = territoryId, AssociationCause = 'Territory2Manual' ),true);
        TerritoryService.updateSaveAccountTerritoryName(new List<Account>{acc});
        acc = [SELECT Id, Territory_Name__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Test Territory',acc.Territory_Name__c);
    }

    @IsTest
    private static void testTerritoryNameUpdateBatch() {
        //Create Account
        Account acc = (Account) TestFactory.createSObject(new Account(), true);
        Id territoryId = [SELECT Id FROM Territory2 WHERE DeveloperName = 'TestTerritory' LIMIT 1].Id;
        TestFactory.createSObject(new ObjectTerritory2Association(ObjectId = acc.Id, Territory2Id = territoryId, AssociationCause = 'Territory2Manual' ),true);
        Test.startTest();
        AccountTerritoryBatchUpdate b = new AccountTerritoryBatchUpdate();
        Database.executeBatch(b,200);
        Test.stopTest();
        acc = [SELECT Id, Territory_Name__c FROM Account WHERE Id = :acc.Id];
        //System.assertEquals('Test Territory',acc.Territory_Name__c);
    }

}