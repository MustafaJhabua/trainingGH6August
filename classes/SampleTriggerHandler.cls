public with sharing class SampleTriggerHandler {
    private Boolean m_isExecuting = false;
    private Integer BatchSize = 0;

    public SampleTriggerHandler(Boolean isExecuting, Integer size) {
        m_isExecuting = isExecuting;
        BatchSize = size;
    }

    public void OnBeforeInsert(Guardant_360_Sample__c[] newRecords) {

    }

    public void OnAfterInsert(Guardant_360_Sample__c[] newRecords) {
        SampleService.processNewSamples(newRecords);
        SampleService.rankSamples(newRecords);
      //  SampleService.createplatformevent(newRecords,'new');
    }

    public void OnAfterDelete(Guardant_360_Sample__c[] deletedRecords, Map<ID, Guardant_360_Sample__c> recordMap) {
         //   SampleService.createplatformevent(deletedRecords,'Delete');

    }

    public void OnBeforeUpdate(Guardant_360_Sample__c[] oldRecords, Guardant_360_Sample__c[] updatedRecords, Map<Id, Guardant_360_Sample__c> oldMap, Map<Id, Guardant_360_Sample__c> newMap) {

    }

    public void OnAfterUpdate(Guardant_360_Sample__c[] oldRecords, Guardant_360_Sample__c[] updatedRecords, Map<Id, Guardant_360_Sample__c> oldMap, Map<Id, Guardant_360_Sample__c> newMap) {
        SampleService.rankSamples(oldMap, newMap);
     //   SampleService.createplatformevent(updatedRecords,'Update');

    }

    public Boolean IsTriggerContext {
        get {
            return m_isExecuting;
        }
    }

    public Boolean IsVisualforcePageContext {
        get {
            return !IsTriggerContext;
        }
    }

    public Boolean IsWebServiceContext {
        get {
            return !IsTriggerContext;
        }
    }

    public Boolean IsExecuteAnonymousContext {
        get {
            return !IsTriggerContext;
        }
    }
}