/**************************************************
     Author : Paramasivan Arunachalam
Description : This test class is written for covering the deleteTrackChangesBatch class and its methods
*****************************************************/
@IsTest(SeeAllData=false)
public with sharing class deleteTrackChangesBatchTest {

   
    @IsTest
    public static void deleteTrackChangesMethod() {
        TrackChanges__c  trackCh = new TrackChanges__c(name='Test',ObjectName__c='Account');
        insert trackCh;
        test.startTest();
        deleteTrackChangesBatch b = new deleteTrackChangesBatch();
        Database.executeBatch(b,50);
        test.stopTest();

    }

}