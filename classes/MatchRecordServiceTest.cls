@IsTest(SeeAllData=false)
private with sharing class MatchRecordServiceTest {

    @TestSetup
    private static void SetupObjects() {
        TestFactory.createSObject(new Match_Record__c(Match_ID__c = 'M0001'), true);
    }

    @IsTest
    private static void beginsWithVowelTrueTest() {
        System.assertEquals(true, MatchRecordService.beginsWithVowel('Apple'));
    }

    @IsTest
    private static void beginsWithVowelFalseTest() {
        System.assertEquals(false, MatchRecordService.beginsWithVowel('Bannana'));
    }

    @IsTest
    private static void yuzuExceptionPath() {
        Match_Record__c match = [SELECT Id, Match_ID__c FROM Match_Record__c LIMIT 1];
        MatchRecordService service = new MatchRecordService();
        service.mRecord = MatchRecordSelector.queryMatchRecordForYuzu(match.Id);
        try {
            service.assignStudyPageURL();
        } catch (YuzuException e) {
            System.assertEquals('Yuzu Exception: There must be at least one Principal Investigator', e.getMessage());
        }
    }

    @IsTest
    private static void yuzuSuccessPath() {
        /*
        Match_Record__c match = [SELECT Id, Match_ID__c FROM Match_Record__c LIMIT 1];
        //Update match record to meet all minimum criteria
        Account acc = (Account) TestFactory.createSObject(new Account(), true);
        Study__c study = (Study__c) TestFactory.createSObject(new Study__c(Pharma_Company__c = acc.Id), true);
        //Add Trial Site
        Study_Site__c connectedTrialSite = (Study_Site__c) TestFactory.createSObject(
                new Study_Site__c(
                        Account_Name__c = 'Test',
                        Study__c = study.Id,
                        PTC_Connection_Preference__c = 'Connect to Trial Site'), true);
        match.Connected_Trial_Site__c = connectedTrialSite.Id;
        update match;
        //Add Trial Site Contact

        Contact con = (Contact) TestFactory.createSObject(new Contact(AccountId = acc.Id), true);
        Studies_Sites_Contact__c trialSiteContact = (Studies_Sites_Contact__c) TestFactory.createSObject(
                new Studies_Sites_Contact__c(
                        Study_Sites__c = connectedTrialSite.Id,
                        Contact__c = con.Id,
                        PTC_Connection_Opt_In__c = true,
                        Email__c = 'test@example.com'
                        ), true);

        MatchRecordService service = new MatchRecordService();
        service.mRecord = MatchRecordSelector.queryMatchRecordForYuzu(match.Id);
        service.assignStudyPageURL();

        //assert the is a link under match record
        */
    }


}