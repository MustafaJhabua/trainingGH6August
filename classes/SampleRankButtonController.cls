public with sharing class SampleRankButtonController {

    //Constructor
    private final SObject mysObject;
    public SampleRankButtonController(ApexPages.StandardController stdController) {
        this.mysObject = (SObject)stdController.getRecord();
    }

    // Code will invoke on page load
    public PageReference autoRun() {
        SampleService.rankSamples(new List<Guardant_360_Sample__c>{(Guardant_360_Sample__c)mysObject});
        PageReference pageRef = new PageReference('/'+mysObject.Id);
        return pageRef;
    }

    public PageReference autoRunPhysicianRank() {
        SampleService.rankSamplesBySinglePhysician(mysObject.Id);
        PageReference pageRef = new PageReference('/'+mysObject.Id);
        return pageRef;
    }
}