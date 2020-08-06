@IsTest
private class REST_MatchRecordBulkUpdateTest {
    private static String testJSON = '{'+
            '   \"records\":['+
            '       {'+
            '       \"match_id\":\"M0001\",'+
            '       \"closest_trial_site\":\"123456dfd\"'+
            '       },'+
            '       {'+
            '       \"match_id\":\"M0002\",'+
            '       \"closest_trial_site\":\"123456dfd\"'+
            '       }'+
            '   ]'+
            '}';

    @TestSetup
    static void setup(){
        //Create Trial Site

        //Create Match Record
        TestFactory.createSObject(new Match_Record__c(Match_ID__c = 'M0001'),true);
    }

    @IsTest
    static void testDecodeMatchRecords() {
        Map<String, MRecord> results = REST_MatchRecordBulkUpdate.decodeMatchRecords(testJSON);
        System.assertEquals(2,results.size());
    }

    @IsTest
    static void testBulkUpdateMR(){
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/mrBulkUpdate';
        req.httpMethod = 'PATCH';
        req.requestBody = Blob.valueOf(testJSON);

        RestContext.request = req;
        REST_MatchRecordBulkUpdate.bulkUpdateMR();
    }

    
}