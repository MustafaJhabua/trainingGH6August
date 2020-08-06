public with sharing class SampleSelector {

//    public static String querySamplesNeedingDelayCase() {
//        return 'SELECT Id, Name, Final_Report_Date__c, Unreported_Sample_Alert_Date__c, Contact__c, Account__c, ' +
//                '(SELECT Id FROM Cases_Samples__r WHERE Subject LIKE \'%Delayed%\') ' +
//                'FROM Guardant_360_Sample__c ' +
//                'WHERE Final_Report_Date__c = NULL AND ' +
//                'Unreported_Sample_Alert_Date__c <= TODAY AND ' +
//                'Unreported_Sample_Alert_Date__c >= 2018-01-01 AND ' +
//                '(Request_Type__c = \'Clinical\' OR Request_Type__c = \'Pharma\') ' +
//                'AND Status__c != \'Resolved\' ' +
//                'AND (NOT Account__r.Name LIKE \'%MIRATI%\') ' +
//                'AND Account_Type__c != \'Test\'';
//    }
    public static String querySamplesToSetPreviousSampleDate() {
        return 'SELECT Id, Contact__c, Date_Received__c, Previous_Date_Received_Contact__c ' +
                'FROM Guardant_360_Sample__c ' +
                'WHERE Previous_Date_Received_Contact__c = null ' +
                'AND CreatedDate = LAST_N_DAYS:1';
    }

    public static List<Guardant_360_Sample__c> querySamplesByContact(Set<Id> contactIds) {
        return [
                SELECT Id, Date_Received__c, Previous_Date_Received_Contact__c, Contact__c
                FROM Guardant_360_Sample__c
                WHERE Contact__c IN :contactIds
                ORDER BY Contact__c ASC, Date_Received__c DESC
        ];
    }

    public static Map<Id, Integer> querySampleCountByNpi(Set<Id> npiIds) {
        List<AggregateResult> groupedResults   = [SELECT COUNT(Id) sampleCount, Contact__r.Actual_NPI__c npi FROM Guardant_360_Sample__c WHERE Contact__r.Actual_NPI__c IN : npiIds GROUP BY Contact__r.Actual_NPI__c];
        if (groupedResults == null){
            return null;
        }
        Map<Id,Integer> resultMap = new Map<Id, Integer>();
        for (AggregateResult result : groupedResults) {
            resultMap.put((Id)result.get('npi'), (Integer)result.get('sampleCount'));
        }
        return resultMap;
    }

    public static List<Guardant_360_Sample__c> querySamplesGroupedByNPI(Set<Id> npiIds) {
        return[
                SELECT Id, Date_Received__c, Test_Count__c, Contact__r.Actual_NPI__c
                FROM Guardant_360_Sample__c
                WHERE Contact__r.Actual_NPI__c IN :npiIds
                AND Contact__r.LastName != 'Applicable'
                ORDER BY Contact__r.Actual_NPI__c ASC, Date_Received__c ASC, Name ASC
        ];
    }

    public static List<Guardant_360_Sample__c> querySamplesGroupedByContact(Set<Id> contactIds) {
        List<Guardant_360_Sample__c> sampleList = new List<Guardant_360_Sample__c>();
        System.debug('*** IN querySamplesGroupedByContact');
        //Added by MJ - Production Issue 23 March 2020 - Added the list collection code only, SOQL is as it is
        System.debug('*** contactIds - '+ contactIds);
        System.debug('*** contactIds - '+ contactIds.size());

        if(contactIds != null && !contactIds.isEmpty()){
            sampleList = [
                SELECT Id, Date_Received__c, Test_Count__c, Contact__c
                ,Contact__r.LastName
                FROM Guardant_360_Sample__c
                WHERE Contact__c != :System.Label.GH_Not_Applicable_Contact_ID // MJ 24 March 2020
                AND Contact__c IN :contactIds
                //AND Contact__r.LastName != 'Applicable'//Commented by MJ 24 March 2020, handling this condition in the caller method in for loop
                ORDER BY Contact__c ASC, Date_Received__c ASC, Name ASC
                Limit 50000// MJ 24 March 2020 
        ];
        }
        System.debug('*** sampleList - '+ sampleList);
        System.debug('*** sampleList - '+ sampleList.size());
        return sampleList;
    }

    public static List<Guardant_360_Sample__c> querySamplesGroupedByPatient(Set<Id> patientIds){
        system.debug('@@@@@@@@@@@@@@@@@'+patientIds);
        List<Guardant_360_Sample__c> gsList = new List<Guardant_360_Sample__c>();
        //Added By siva for Null check On March 20,2020

        if(patientIds != null && !patientIds.isEmpty()){
       
             gsList =  [ SELECT Id, Date_Received__c, Test_Count__c, Patient__c, Patient_Test_Count__c
                FROM Guardant_360_Sample__c
                WHERE Patient__c IN :patientIds
                ORDER BY Patient__c ASC, Date_Received__c ASC, Name ASC];
                
        
        }
        return gsList;
        
    }
}