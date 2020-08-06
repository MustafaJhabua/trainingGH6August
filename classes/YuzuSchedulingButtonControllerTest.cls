@IsTest(SeeAllData=false)
private with sharing class YuzuSchedulingButtonControllerTest {

    @TestSetup
    private static void SetupObjects() {
        TestFactory.createSObject(new Match_Record__c(Match_ID__c = 'M0001'),true);
    }

    @IsTest
    private static void testYuzuButtonPush(){
        //TODO This tests the exception path since match record missing values. Need to also test good path and assert
        Match_Record__c match = [SELECT Id, Match_ID__c FROM Match_Record__c LIMIT 1];
        PageReference pageRef = Page.vfGetYuzuLink;
        ApexPages.StandardController sc = new ApexPages.StandardController(match);
        YuzuSchedulingButtonController myPageCon = new YuzuSchedulingButtonController(sc);
        Test.setCurrentPage(pageRef);
        myPageCon.autoRun();
    }
}