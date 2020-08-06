@IsTest
private class MatchRecordTriggerTest {
    static testMethod void makeMR() {

        Account acc = (Account) TestFactory.createSObject(new Account(), true);
        Contact con = (Contact) TestFactory.createSObject(new Contact(AccountId = acc.Id), true);
        Match_Record__c mr = (Match_Record__c) TestFactory.createSObject(new Match_Record__c(
                Name = '1',
                Match_ID__c = '1',
                Ordering_Physician_Name__c = con.Id), true);

        update mr;
        delete mr;
    }

}