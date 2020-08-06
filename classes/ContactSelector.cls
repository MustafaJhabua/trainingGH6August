public with sharing class ContactSelector {

//    public static List<Contact> qualifiedContactsSortedByEmailAndSampleCount(Set<String> emails) {
//        return [
//                SELECT Id, Email, Marketable_User__c, Actual_NPI__c
//                FROM Contact
//                WHERE Email IN :emails
//                AND Contact_Role__c IN :ContactService.MARKETABLE_CONTACT_ROLES
//                AND Account_Type__c = 'Clinical Account US'
//                AND (NOT (Number_of_Samples__c > 0 AND Unqualified_by_CS__c = TRUE))
//                ORDER BY Actual_NPI__c ASC, Email ASC, Number_of_Samples__c DESC, Last_Sample_Date__c DESC, CreatedDate DESC
//        ];
//
//        //Possible improvement to this query: Run query above and pull out all NPI numbers, run a second query for all contacts with the same NPI number and re-query larger list and rank
//    }

    public static List<Contact> qualifiedContactsSortedByNpiAndEmailAndSampleCount(Set<String> emails) {
        Set<Id> npiIds = new Set<Id>();
        for (Contact con : [
                SELECT Id, Actual_NPI__c
                FROM Contact
                WHERE Email IN :emails
                AND Contact_Role__c IN :ContactService.MARKETABLE_CONTACT_ROLES
                AND Account_Type__c = 'Clinical Account US'
                AND (NOT (Number_of_Samples__c > 0 AND Unqualified_by_CS__c = TRUE))
        ]) {
            if (con.Actual_NPI__c != null) {
                npiIds.add(con.Actual_NPI__c);
            }
        }
        return [
                SELECT Id, Email, Marketable_User__c, Actual_NPI__c
                FROM Contact
                WHERE (Email IN :emails OR Actual_NPI__c IN :npiIds)
                AND Contact_Role__c IN :ContactService.MARKETABLE_CONTACT_ROLES
                AND Account_Type__c = 'Clinical Account US'
                AND (NOT (Number_of_Samples__c > 0 AND Unqualified_by_CS__c = TRUE))
                ORDER BY Actual_NPI__c ASC, Email ASC, Number_of_Samples__c DESC, Last_Sample_Date__c DESC, CreatedDate DESC
        ];

    }


    public static Map<Id, Id> contactIdsWithNpiNumber(Set<Id> contactIds) {
        Map<Id, Id> contactNPIMap = new Map<Id, Id>();
        for (Contact con : [SELECT Id, Actual_NPI__c FROM Contact WHERE Id IN :contactIds AND Actual_NPI__c != NULL]) {
            contactNPIMap.put(con.Id, con.Actual_NPI__c);
        }
        return contactNPIMap;
    }


}