public with sharing class AdminBatchExecuteController {

    public PageReference runTerritoryBatch(){
        AccountTerritoryBatchUpdate b = new AccountTerritoryBatchUpdate();
        Database.executeBatch(b,10);
        return null;
    }

    public PageReference runMatchBatch(){
        matchBatch_Batch b = new matchBatch_Batch();
        Database.executeBatch(b, 1);
        return null;
    }
}