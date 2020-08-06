@IsTest(SeeAllData=false)
public with sharing class PatientServiceTest {

    @TestSetup
    public static void setupObjects() {
        AdminTriggerToggle__c toggle = new AdminTriggerToggle__c();
        toggle.Bypass_Contact_Trigger__c = false;
        insert toggle;
        TestFactory.createSObject(new Patient__c(), true);

    }

    @IsTest
    public static void testUpdateMatchPanelFields() {
        Patient__c patient = [SELECT Id, Show_to_Customer_Match_Key_s__c FROM Patient__c LIMIT 1];
        System.assertEquals(null, patient.Show_to_Customer_Match_Key_s__c);
        TestFactory.createSObject(new Match_Record__c(
                Patient_ID__c = patient.Id,
                Show_to_Customer__c = true,
                Match_Key__c = 'test'), true);
        PatientService.updateMatchPanelFields(new Set<Id>{patient.Id});
        patient = [SELECT Id, Show_to_Customer_Match_Key_s__c FROM Patient__c LIMIT 1];
        System.assertEquals('test', patient.Show_to_Customer_Match_Key_s__c);
    }

    @IsTest
    public static void testGetLocalDateTime() {
        Datetime now = Datetime.now();
        Datetime localNow = PatientService.getLocalDateTime(now);
        System.assert(now != localNow);
    }

}