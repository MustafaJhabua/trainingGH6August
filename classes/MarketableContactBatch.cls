public class MarketableContactBatch implements Database.Batchable<SObject>{
    Set<String> marketableContactRoles = ContactService.MARKETABLE_CONTACT_ROLES;
    private String query = 'SELECT Id, Number_of_Samples__c, Account_Type__c,Unqualified_by_CS__c, Contact_Role__c, Email, Marketable_User__c ' +
            'FROM Contact WHERE (Email != null AND Contact_Role__c IN :marketableContactRoles) ' +
            'OR Marketable_User__c = TRUE '+
            'ORDER BY Actual_NPI__c ASC, Email ASC';

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope){
        ContactService service = new ContactService();
        service.markContactMarketable(scope);
    }
    public void finish(Database.BatchableContext bc){

    }
}