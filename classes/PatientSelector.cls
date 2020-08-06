public with sharing class PatientSelector {

    public static List<Patient__c> matchRecordsByPatient(Set<Id> patientIds) {
        return [
                SELECT Id, (
                        SELECT Id,
                                Match_Key__c,
                                Show_to_Customer__c,
                                Outreach_Email_Sent__c,
                                Outreach_Email_Read__c,
                                Replied_to_Outreach_Email__c,
                                Contact_Attempted__c,
                                Last_Ditch_Email_Sent__c,
                                Replied_to_Last_Ditch_Email__c,
                                Contact_Achieved__c,
                                Referred__c,
                                Permission_to_Connect_with_Pharma__c,
                                Pharma_PTC_Alert_Sent__c,
                                Screened__c,
                                Enrolled__c,
                                Closed__c,
                                Date_Show_to_Pharma__c,
                                Date_Outreach_Email_Sent__c,
                                Date_Outreach_Email_Read__c,
                                Date_Replied_to_Outreach_Email__c,
                                Date_Contact_Attempted__c,
                                Date_Last_Ditch_Email_Sent__c,
                                Date_Replied_to_Last_Ditch_Email__c,
                                Date_Contact_Achieved__c,
                                Date_Referred__c,
                                Date_Pharma_Permission_to_Connect__c,
                                Date_PTC_Alert_Sent__c,
                                Date_Screened__c,
                                Date_Enrolled__c,
                                Date_Closed__c
                        FROM Match_Records__r
                        WHERE IsDeleted = FALSE
                        ORDER BY Match_Key__c ASC
                )
                FROM Patient__c
                WHERE Id IN :patientIds
        ];
    }
}