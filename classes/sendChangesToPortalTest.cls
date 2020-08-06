@IsTest
private class sendChangesToPortalTest {
static testMethod void setReferralsubstatusTest(){
        Match_Record__c mr = new Match_Record__c();
        List <Match_Record__c> mrList = new List <Match_Record__c>();
        
        Account acc = (Account)TestFactory.createSObject(new Account(),true);
        Contact con = (Contact)TestFactory.createSObject(new Contact(AccountId = acc.Id),true);
        TestFactory.createSObject(new Guardant_360_Sample__c(
                Name = 'name',
                Contact__c = con.Id,
                Account__c = acc.Id),true);
        
        mr.Name = 'name';
        mr.Match_ID__c = 'name';
        mr.Portal_Sample_ID__c = 'sample';
        mr.Last_Match_API_Update__c = System.now();
        
        insert mr;
        mrList.add(mr);
        test.starttest();
        sendChangesToPortal.sendValuesToPortal(mrList);
        test.stoptest();
}
}