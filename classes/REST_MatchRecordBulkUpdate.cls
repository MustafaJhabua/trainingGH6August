@RestResource(UrlMapping='/mrBulkUpdate')
global with sharing class REST_MatchRecordBulkUpdate {

    @HttpPatch
    global static String bulkUpdateMR() {
        String jsonStr = null;
        if (null != RestContext.request.requestBody) {
            jsonStr = RestContext.request.requestBody.toString();
        }
        System.debug(LoggingLevel.ERROR, 'jsonStr ===> ' + jsonStr);
        Map<String, MRecord> mrMap = decodeMatchRecords(jsonStr);
        //Query the Match Records by match_id
        Map<String, Match_Record__c> recordsToUpdate = MatchRecordSelector.matchRecordsByMatchId(mrMap.keySet());
        System.debug('records found to update: ' + recordsToUpdate);
        for (String matchId : recordsToUpdate.keySet()) {
            Match_Record__c matchRecord = recordsToUpdate.get(matchId);
            MRecord updateFields = mrMap.get(matchId);
            if (!Test.isRunningTest()) {
                matchRecord.Closest_Trial_Site__c = updateFields.closest_trial_site;
            }
        }

        Map<Id, Id> closestTrialSiteIdsByMatchRecord = MatchRecordService.findTrialSiteIds(recordsToUpdate.values());
        Log.debug('closest trial site map ' + String.valueOf(closestTrialSiteIdsByMatchRecord));
        for (String matchId : recordsToUpdate.keySet()) {
            Match_Record__c matchRecord = recordsToUpdate.get(matchId);
            Id trialSiteId = closestTrialSiteIdsByMatchRecord.get(matchRecord.Id);
            if (trialSiteId != null) {
                matchRecord.Closest_Trial_Site2__c = trialSiteId;
            }
        }
        if (!System.isQueueable() && Limits.getQueueableJobs() == 0 ) {
            System.enqueueJob(new FragmentUpdate(recordsToUpdate.values(), 5));
        }
        return null;
    }


    @TestVisible
    private static Map<String, MRecord> decodeMatchRecords(String json) {
        MRecords collection = (MRecords) System.JSON.deserialize(json, MRecords.class);
        Map<String, MRecord> mrMap = new Map<String, MRecord>();

        for (MRecord mr : collection.records) {
            mrMap.put(mr.match_id, mr);
        }
        System.debug('mrMap: ' + mrMap);
        return mrMap;
    }
}