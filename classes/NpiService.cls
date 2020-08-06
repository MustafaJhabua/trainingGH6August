public with sharing class NpiService {

    public static void updateTotalSamples(Set<Id> npiIds){
        Map<Id,Integer> samplesByNpi = SampleSelector.querySampleCountByNpi(npiIds);
        List<NPI_Records__c> npiRecordsToUpdate = new List<NPI_Records__c>();
        for (Id npiId : samplesByNpi.keySet()) {
            npiRecordsToUpdate.add(new NPI_Records__c(Id = npiId, Total_Samples__c = samplesByNpi.get(npiId)));
        }
        if(npiRecordsToUpdate !=  null){
            System.debug('===npiservice update: '+npiRecordsToUpdate);
            update npiRecordsToUpdate;
        }
    }
}