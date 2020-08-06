public with sharing class MatchRecordSelector {


    public static Map<String, Match_Record__c> matchRecordsByMatchId(Set<String> matchIds) {
        Map<String, Match_Record__c> result = new Map<String, Match_Record__c>();
        for (Match_Record__c mr : [
                SELECT Id,
                        Match_ID__c,
                        Closest_Trial_Site__c,
                        Trial_Name__c
                FROM Match_Record__c
                WHERE Match_ID__c IN :matchIds
        ]) {
            result.put(mr.Match_ID__c, mr);
        }
        return result;
    }

    public static Match_Record__c queryMatchRecordForYuzu(Id matchRecordId) {
        return [
                SELECT Id,
                        Connected_Trial_Site__c,
                        Match_Key__c,
                        Patient_Initials__c,
                        Qualifying_Target_Alterations__c,
                        Final_Report_Date__c,
                        MD_First_Name__c,
                        MD_Last_Name__c,
                        Physician_Email__c,
                        Physician_phone__c,
                        Ordering_Practice_Name__r.Name,
                        Practice_Address__c,
                        Practice_City__c,
                        Practice_State__c,
                        Practice_Zip__c,
                        Trial_label__c,
                        Connected_Trial_Site__r.Site__r.Name,
                        Connected_Trial_Site_Address__c,
                        Connected_Trial_Site_City__c,
                        Connected_Trial_Site_State__c,
                        Connected_Trial_Site_Zip_Code__c,
                        Cancer_Type_Lower_Case__c,
                        Portal_Link_For_MD_text__c,
                        Trial_Name__r.Study_Title__c,
                        Trial_Name__r.NCT_Identifier__c,
                        Trial_Name__r.Trial_Code__c
                FROM Match_Record__c
                WHERE Id = :matchRecordId
        ];
    }
}