@IsTest(SeeAllData=false)
public with sharing class NpiServiceTest {

    @TestSetup
    private static void setupObjects(){
        //Create Account
        Account a1 = (Account) TestFactory.createSObject(new Account(), true);
        //Create NPI
        NPI_Records__c npi = (NPI_Records__c)TestFactory.createSObject(new NPI_Records__c(NPI_Number__c = '12345'),true);
        //Create Contact
        Contact c1 = (Contact) TestFactory.createSObject(new Contact(AccountId = a1.Id, Actual_NPI__c = npi.Id),true);
    }

    @IsTest
    private static void testUpdateTotalSamplesNoSamples() {
        NpiService.updateTotalSamples(getNpiRecords().keySet());
        for (NPI_Records__c npiRecord : getNpiRecords().values()) {
            System.assertEquals(null,npiRecord.Total_Samples__c);
        }
    }

    @IsTest
    private static void testUpdateTotalSamples() {
        //Get Contact
        Contact con = [SELECT Id, AccountId FROM Contact LIMIT 1];
        //Create Samples
        TestFactory.createSObjectList(new Guardant_360_Sample__c(Contact__c = con.Id, Account__c = con.AccountId),20,true);
        NpiService.updateTotalSamples(getNpiRecords().keySet());
        for (NPI_Records__c npiRecord : getNpiRecords().values()) {
            System.assertEquals(20,npiRecord.Total_Samples__c);
        }
    }

    private static Map<Id,NPI_Records__c> getNpiRecords(){
        return new Map<Id,NPI_Records__c>([SELECT Id, Total_Samples__c FROM NPI_Records__c]);
    }
}