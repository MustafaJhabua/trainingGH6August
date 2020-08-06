public with sharing class QUEUEABLE_ContactLastSampleDate implements Queueable {
    public Set<Id> contactIds = new Set<Id>();

    public QUEUEABLE_ContactLastSampleDate(Set<Id> contactIds) {
        this.contactIds = contactIds;
    }

    public void execute(QueueableContext context) {
        List<Contact> contactList = [
                SELECT Id, Actual_NPI__c, (
                        SELECT Id, Date_Received__c
                        FROM Guardant_360_Samples__r
                        ORDER BY Date_Received__c DESC
                        LIMIT 1
                )
                FROM Contact
                WHERE Id IN :contactIds
        ];
        Set<Id> npiIds = new Set<Id>();
        for (Contact c : contactList) {
            c.Last_Sample__c = c.Guardant_360_Samples__r[0].Id;
            if (c.Actual_NPI__c != null) {
                npiIds.add(c.Actual_NPI__c);
            }
        }
        update contactList;
        //send NPI set to Method
        //System.debug('===npiIds: ' + npiIds);
        if(npiIds.size()>0){
            NpiService.updateTotalSamples(npiIds);
        }



    }

}