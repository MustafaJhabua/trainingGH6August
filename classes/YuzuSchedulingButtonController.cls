public with sharing class YuzuSchedulingButtonController {

    //Constructor
    private final SObject mysObject;
    public YuzuSchedulingButtonController(ApexPages.StandardController stdController) {
        this.mysObject = (SObject)stdController.getRecord();
    }

    // Code will invoke on page load
    public PageReference autoRun() {
        Id matchRecordId = mysObject.Id;

        MatchRecordService service = new MatchRecordService();
        service.mRecord = MatchRecordSelector.queryMatchRecordForYuzu(matchRecordId);
        try {
            service.assignStudyPageURL();

        }catch (Exception e){
            System.debug(e);
            ApexPages.addMessages(e);
            return null;
        }
        PageReference pageRef = new PageReference('/' + matchRecordId);
        return pageRef;
    }

}