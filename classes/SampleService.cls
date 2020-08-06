/*
Modification Log
Modified by     Description 

Siva           Added a new method

siva          Added comments (Marh 18,2019)

*/
public with sharing class SampleService {
    
    // Called on after insert operation
    public static void processNewSamples(List<Guardant_360_Sample__c> newRecords) {
        System.debug('*** processNewSamples - ');
        System.debug('*** newRecords - '+ newRecords);
        System.debug('*** newRecords - '+ newRecords.size());
        SampleService.rankSamples(newRecords);
        
        // getting all related contacts from sample record
        Set<Id> associatedContactIds = new Set<Id>();
        for (Guardant_360_Sample__c sample : newRecords) {
            associatedContactIds.add(sample.Contact__c);
            System.debug('*** sample.Contact__c - '+ sample.Contact__c);
        }
        if(!System.isQueueable() && Limits.getQueueableJobs() == 0){
            // updating the contact with last sample date
            System.enqueueJob(new QUEUEABLE_ContactLastSampleDate(associatedContactIds));
        }
    }
    
    public static void rankSamples(List<Guardant_360_Sample__c> samples) {
        rankSamples(null, new Map<Id, Guardant_360_Sample__c>(samples));
    }
    public static void rankSamples(Map<Id, Guardant_360_Sample__c> oldRecords, Map<Id, Guardant_360_Sample__c> newRecords) {
        //Rank by Physician only if contact exists or updated
        List<Guardant_360_Sample__c> samplesWithContact = new List<Guardant_360_Sample__c>();
        for (Id sampleId : newRecords.keySet()) {
            Guardant_360_Sample__c newSample = newRecords.get(sampleId);
            // Below loop run for new sample record with contact
            if (oldRecords == null && newSample.Contact__c != null) {
                samplesWithContact.add(newSample);
                continue;
            }
            // following for old sample reord with contact
            Guardant_360_Sample__c oldSample = oldRecords.get(sampleId);
            Boolean contactupdated = oldSample.Contact__c != newSample.Contact__c;
            Boolean patientupdated = oldSample.Patient__c != newSample.Patient__c;
            Boolean nullRankWithContact = newSample.Contact__c != null && newSample.Patient_Test_Count__c == null;
            //Commented by MJ - Production Issue 23 March 2020
            //if (contactupdated || patientupdated || nullRankWithContact) {
            //  samplesWithContact.add(newSample);
            //}
            //Added by MJ - Production Issue 23 March 2020
            if(((oldSample.Contact__c != newSample.Contact__c) || (oldSample.Patient__c != newSample.Patient__c) || newSample.Patient_Test_Count__c == null) && (newSample.Contact__c != null)) {
                samplesWithContact.add(newSample);
                System.debug('*** newSample - '+ newSample);
            }
        }
        System.debug('*** samplesWithContact '+ samplesWithContact);
        System.debug('*** samplesWithContact '+ samplesWithContact.size());
        Map<Id, Guardant_360_Sample__c> samplesToUpdate = rankSamplesByPhysician(samplesWithContact);
        //Send only those samples that were in the original set to update patient
        List<Guardant_360_Sample__c> samplesForPatientRanking = new List<Guardant_360_Sample__c>();
        for (Guardant_360_Sample__c sample : samplesWithContact) {
            Guardant_360_Sample__c updatedSampleRecord = samplesToUpdate.get(sample.Id);
            if (updatedSampleRecord != null) {
                samplesForPatientRanking.add(updatedSampleRecord);
            } else {
                samplesForPatientRanking.add(sample);
            }
        }
        
        Map<Id, Guardant_360_Sample__c> updatedSamplesByPatient = rankSamplesByPatient(samplesForPatientRanking);
        //Merge the two Maps
        samplesToUpdate.putAll(updatedSamplesByPatient);
        Log.debug('Samples To Update: '+String.valueOf(samplesToUpdate));
        if (samplesToUpdate.size() > 0) {
            if(samplesToUpdate.size() <= 5){
                update samplesToUpdate.values();
            }
            
            if(!System.isQueueable() && Limits.getQueueableJobs() == 0){
                System.enqueueJob(new FragmentUpdate(samplesToUpdate.values(), 5));
            }
        }
    }
    
    public static void rankSamplesBySinglePhysician(Id contactId) {
        Map<Id, Guardant_360_Sample__c> samplesToUpdate = rankSamplesByPhysician(new Set<Id>{contactId});
        Log.debug(String.valueOf(samplesToUpdate));
        if (samplesToUpdate.size() > 0) {
            if(samplesToUpdate.size() <= 5){
                update samplesToUpdate.values();
            }
            
            if(!System.isQueueable() && Limits.getQueueableJobs() == 0){
                System.enqueueJob(new FragmentUpdate(samplesToUpdate.values(), 5));}
        }
        
    }
    
    public static Map<Id, Guardant_360_Sample__c> rankSamplesByPhysician(Set<Id> contactIds) {
        System.debug('*** rankSamplesByPhysician');
        Map<Id, Id> contactsWithNpi = ContactSelector.contactIdsWithNpiNumber(contactIds);
        System.debug('*** contactsWithNpi - '+ contactsWithNpi);
        Set<Id> contactIdsWithoutNpiIds = contactIds;
        Set<Id> contactIdsWithNpiIds = contactsWithNpi.keySet();
        Log.debug('All contacts '+String.valueOf(contactIds));
        for(Id contactId: contactIds){
            if(contactIdsWithNpiIds.contains(contactId)){
                contactIdsWithoutNpiIds.remove(contactId);
            }
        }
        Log.debug('Contacts without NPI: '+String.valueOf(contactIdsWithoutNpiIds));
        Set<Id> npiIds = new Set<Id>(contactsWithNpi.values());
        Map<Id, Guardant_360_Sample__c> samplesToUpdate = rankSamplesByPhysicianFromNPIs(npiIds);
        System.debug('*** contactIdsWithoutNpiIds - '+contactIdsWithoutNpiIds);
        System.debug('*** contactIdsWithoutNpiIds - '+contactIdsWithoutNpiIds.size());
        samplesToUpdate.putAll(rankSamplesByPhysicianFromContactId(contactIdsWithoutNpiIds));
        return samplesToUpdate;
    }
    
    public static Map<Id, Guardant_360_Sample__c> rankSamplesByPhysician(List<Guardant_360_Sample__c> samples) {
        Set<Id> contactIds = contactIdsFromSamples(samples);
        return rankSamplesByPhysician(contactIds);
    }
    
    public static Map<Id, Guardant_360_Sample__c> rankSamplesByPhysicianFromNPIs(Set<Id> npiIds) {
        Integer rankCounter = null;
        Id currentNpiId = null;
        Map<Id, Guardant_360_Sample__c> samplesToUpdate = new Map<Id, Guardant_360_Sample__c>();
        for (Guardant_360_Sample__c sample : SampleSelector.querySamplesGroupedByNPI(npiIds)) {
            if (currentNpiId == null || currentNpiId != sample.Contact__r.Actual_NPI__c) {
                currentNpiId = sample.Contact__r.Actual_NPI__c;
                rankCounter = 0;
            }
            rankCounter++;
            if (sample.Test_Count__c != rankCounter) {
                sample.Test_Count__c = rankCounter;
                samplesToUpdate.put(sample.Id, sample);
            }
        }
        return samplesToUpdate;
    }
    public static Map<Id, Guardant_360_Sample__c> rankSamplesByPhysicianFromContactId(Set<Id> contactIds) {
        System.debug('*** rankSamplesByPhysicianFromContactId - ');
        Integer rankCounter = null;
        Id currentContactId = null;
        Map<Id, Guardant_360_Sample__c> samplesToUpdate = new Map<Id, Guardant_360_Sample__c>();
        System.debug('*** contactIds - '+ contactIds);
        System.debug('*** contactIds - '+ contactIds.size());
        for (Guardant_360_Sample__c sample : SampleSelector.querySamplesGroupedByContact(contactIds)) {
            System.debug('*** sample - '+ sample);
            System.debug('*** sample Contact__c - '+ sample.Contact__c);
            System.debug('*** sample Contact__r.LastName - '+ sample.Contact__r.LastName);
            
            if(sample.Contact__r.LastName != 'Applicable'){//MJ Added 24 March 2020 - Only this IF condition added
                if (currentContactId == null || currentContactId != sample.Contact__c) {
                    currentContactId = sample.Contact__c;
                    rankCounter = 0;
                }
                rankCounter++;
                if (sample.Test_Count__c != rankCounter) {
                    sample.Test_Count__c = rankCounter;
                    samplesToUpdate.put(sample.Id, sample);
                }
            }
        }
        
        return samplesToUpdate;
    }
    
    public static Map<Id, Guardant_360_Sample__c> rankSamplesByPatient(List<Guardant_360_Sample__c> samples) {
        Set<Id> patientIds = patientIdsFromSamples(samples);
        return rankSamplesByPatientFromPatientIds(patientIds, samples);
    }
    
    //    public static Map<Id, Guardant_360_Sample__c> rankSamplesByPatientFromPatientIds(Set<Id> patientIds) {
    //        return rankSamplesByPatientFromPatientIds(patientIds, new List<Guardant_360_Sample__c>());
    //    }
    
    public static Map<Id, Guardant_360_Sample__c> rankSamplesByPatientFromPatientIds(Set<Id> patientIds, List<Guardant_360_Sample__c> samples) {
        Map<Id, Guardant_360_Sample__c> sampleMap = new Map<Id, Guardant_360_Sample__c>(samples);
        Integer rankCounter = null;
        Id currentPatientId = null;
        Map<Id, Guardant_360_Sample__c> samplesToUpdate = new Map<Id, Guardant_360_Sample__c>();
        for (Guardant_360_Sample__c sample : SampleSelector.querySamplesGroupedByPatient(patientIds)) {
            
            if (currentPatientId == null || currentPatientId != sample.Patient__c) {
                currentPatientId = sample.Patient__c;
                rankCounter = 0;
            }
            
            rankCounter++;
            System.debug('Patient/Sample Update: ' + sample);
            System.debug('rank counter: : ' + rankCounter);
            if (sample.Patient_Test_Count__c != rankCounter) {
                sample.Patient_Test_Count__c = rankCounter;
                Guardant_360_Sample__c originalSample = sampleMap.get(sample.Id);
                if (originalSample != null) {
                    sample.Test_Count__c = originalSample.Test_Count__c; //don't overwrite the physician rank when updating the patient rank
                }
                System.debug('Patient/Sample Final: ' + sample);
                samplesToUpdate.put(sample.Id, sample);
            }
        }
        return samplesToUpdate;
    }
    
    
    public static Set<Id> patientIdsFromSamples(List<Guardant_360_Sample__c> samples) {
        Set<Id> patientIds = new Set<Id>();
        for (Guardant_360_Sample__c sample : samples) {
            //Added By siva for Null check On March 20,2020
            if(sample.Patient__c!= null){
                patientIds.add(sample.Patient__c);
            }
        }
        return patientIds;
    }
    
    
    public static Set<Id> contactIdsFromSamples(List<Guardant_360_Sample__c> samples) {
        Set<Id> contactIds = new Set<Id>();
        for (Guardant_360_Sample__c sample : samples) {
            if(sample.Contact__c != null){//Added by MJ - Production Issue 22 March 2020
                contactIds.add(sample.Contact__c);
            }
        }
        return contactIds;
    }
    
    
    //    public static void processDelayedSamples(List<Guardant_360_Sample__c> samples) {
    //        List<Guardant_360_Sample__c> samplesThatNeedCase = new List<Guardant_360_Sample__c>();
    //        for (Guardant_360_Sample__c sample : samples) {
    //            if (sample.Cases_Samples__r.size() == 0) {
    //                samplesThatNeedCase.add(sample);
    //            }
    //        }
    //        if (samplesThatNeedCase.size() > 0) {
    //            //Send to case create method
    //            CaseService.createDelayedSampleCases(samplesThatNeedCase);
    //        }
    //    }
    
    public static void setPreviousSampleDate(List<Guardant_360_Sample__c> samples) {
        Set<Id> contactIds = new Set<Id>();
        
        for (Guardant_360_Sample__c sample : samples) {
            contactIds.add(sample.Contact__c);
        }
        
        //query all samples for contacts
        List<Guardant_360_Sample__c> allSamples = SampleSelector.querySamplesByContact(contactIds);
        List<Guardant_360_Sample__c> samplesToUpdate = new List<Guardant_360_Sample__c>();
        Id currentContactId = null;
        Id currentSampleId = null;
        Boolean lastRun = false;
        for (Guardant_360_Sample__c sample : allSamples) {
            if (lastRun && currentContactId == sample.Contact__c) {
                continue;
            }
            lastRun = false;
            if (currentContactId != sample.Contact__c && sample.Previous_Date_Received_Contact__c == null) {
                currentContactId = sample.Contact__c;
                currentSampleId = sample.Id;
                continue;
            }
            if (currentSampleId != null && currentSampleId != sample.Id) {
                samplesToUpdate.add(new Guardant_360_Sample__c(
                    Id = currentSampleId, Previous_Date_Received_Contact__c = sample.Date_Received__c));
                currentSampleId = sample.Id;
            }
            if (sample.Previous_Date_Received_Contact__c != null) {
                lastRun = true;
            }
        }
        update samplesToUpdate;
    }
    
    /*This method is for populating values on the field.This method is for replacing workflow rules.
Author : siva
method name : populateFieldValues
*/
    /* public static void populateFieldValues(List<Guardant_360_Sample__c> newSample){


List<string> accountids = new List<string>();
List<string> contactids = new List<string>();
map<id,contact> contactmap = new  map<id,contact>();
map<id,account> accountmap = new map<id,account>();
for(Guardant_360_Sample__c gs: newsample){
getting account and contact id for querying the fields from account and contact
accountids.add(gs.Account__c);
contactids.add(gs.Contact__c);
}

if(accountids.size() > 0){
accountmap = new map<id,account>([select id,Owner.Manager.Email from account where id in:accountids]);
}
if(contactids.size() > 0){
contactmap = new map<id,contact>([select id,Primary_Opt_In__c,
Portal_Primary__c,Secondary_Opt_In__c, 
Portal_Secondary__c,Tertiary_Opt_In__c, 
Portal_Tertiary__c,Quaternary_Opt_In__c, 
Portal_Quaternary__c,Quinary_Opt_In__c, 
Portal_Quinary__c,Senary_Opt_In__c, 
Portal_Senary__c from contact where id in:contactids]);
}

for(Guardant_360_Sample__c gs: newsample){

//Auto fillinng sample counter

if(gs.name != null){

gs.SampleCounter__c = constantUtility.SAMPLE_Counter;
}
// Auto fill UE portal email address
if(gs.createddate > date.valueof(constantUtility.CREATEDDATE_FILLINGEMAIL)){

if(gs.contact__c != null && contactmap.get(gs.contact__c) != null){

IF( contactmap.get(gs.contact__c).Primary_Opt_In__c){
gs.Portal_Primary_Email_Address__c = contactmap.get(gs.contact__c).Portal_Primary__c;
}

IF( contactmap.get(gs.contact__c).Secondary_Opt_In__c){
gs.Portal_Secondary_Email_Address__c = contactmap.get(gs.contact__c).Portal_Secondary__c;
}

IF( contactmap.get(gs.contact__c).Tertiary_Opt_In__c){
gs.Portal_Tertiary_Email_Address__c = contactmap.get(gs.contact__c).Portal_Tertiary__c;
}

IF( contactmap.get(gs.contact__c).Quaternary_Opt_In__c){
gs.Portal_Quaternary_Email_Address__c = contactmap.get(gs.contact__c).Portal_Quaternary__c;
}

IF( contactmap.get(gs.contact__c).Quinary_Opt_In__c){
gs.Portal_Quinary_Email_Address__c = contactmap.get(gs.contact__c).Portal_Quinary__c;
}

IF( contactmap.get(gs.contact__c).Senary_Opt_In__c){
gs.Portal_Senary_Email_Address__c = contactmap.get(gs.contact__c).Portal_Senary__c;
}

}
}
//Following condition for Guardant challenge notification
if(gs.Promotion_Code__c == constantUtility.PROMOTIONCODE_CH1 && gs.CH1_Notification_Sent__c == false){
gs.CH1_Notification_Sent__c = true;
}

// Updating RDS email
if(gs.Date_Received__c > date.valueof(constantUtility.DATE_RECEIVED_RDS) && gs.RSD_Email__c == null){
if(gs.account__c != null){
if(accountmap.get(gs.account__c) != null){

gs.RSD_Email__c = accountmap.get(gs.account__c).Owner.Manager.Email;
}
}
}

// UE New report international
if(gs.Sales_Region__c == constantUtility.SALESREGION_INTERNATIONAL
&& gs.UE_Sample_Workflow__c == null && gs.Final_Report_Date__c == date.valueOf(constantUtility.FINALREPORT_DATE)&&  gs.New_International_Report_Released__c == null){
gs.New_International_Report_Released__c = date.today();
gs.UE_Sample_Workflow__c = constantUtility.UE_SAMPLE_ILReport;
}

//UE Basic Email Send for ACCA
string statusname = label.Sample_Status;
list<string> statusset = statusname.split(',');
if(gs.Date_Received__c != null && gs.Date_Received__c > date.valueof(constantUtility.DATE_RECEIVED_ACCA) && gs.Final_Report_Date__c != null && statusset.contains(gs.Status__c) && gs.ACCA_Notification_Sent__c == null){
gs.ACCA_Notification_Sent__c = date.today();
gs.UE_Sample_Workflow__c = constantUtility.UE_SAMPLE_BASIC;
gs.Basic_Report_Released_email_sent__c = date.today();
}

//Research/Validation Sample || UE Opt Out
string ResearchValidationOptout= label.ResearchValidationOptout;
list<string> ResearchValidationSet = ResearchValidationOptout.split(',');
if(ResearchValidationSet.contains(gs.Request_Type__c) && gs.UE_Sample_Workflow__c == null){
gs.UE_Sample_Workflow__c = constantUtility.UE_SAMPLE_NONE;
}

}
}*/
    
    // This method added by siva. This will get the lims project id
    public static void populateProjectId(List<Guardant_360_Sample__c> newSample,map<id,Guardant_360_Sample__c> oldMap){
        set<string> projectId = new set<string>();
        map<string,LIMS_Project_ID__c> projectIdMap = new map<string,LIMS_Project_ID__c>();
        for(Guardant_360_Sample__c gsample:newSample){
            if(gsample.LIMS_Project_ID__c != null && !Label.ClinicalSamples.contains(gsample.LIMS_Project_ID__c) && oldMap == null){
                projectId.add(gsample.LIMS_Project_ID__c);
            }
            
            if(oldMap != null && gsample.LIMS_Project_ID__c != oldMap.get(gsample.id).LIMS_Project_ID__c){
                projectId.add(gsample.LIMS_Project_ID__c);
            }
        }
        
        if(projectId.size() > 0){
            
            for(LIMS_Project_ID__c lims:[select SOW__c,LIMS_Project_ID__c,id from LIMS_Project_ID__c where LIMS_Project_ID__c in:projectId]){
                projectIdMap.put(lims.LIMS_Project_ID__c,lims);
            }
            
            for(Guardant_360_Sample__c gsample:newSample){
                if(projectIdMap.get(gsample.LIMS_Project_ID__c) != null){
                    gsample.LIMS_Project_ID_lookup__c = projectIdMap.get(gsample.LIMS_Project_ID__c).id;
                    gsample.SOW__c  = projectIdMap.get(gsample.LIMS_Project_ID__c).SOW__c != null? projectIdMap.get(gsample.LIMS_Project_ID__c).SOW__c:gsample.SOW__c;
                }
            }
            
        }
        
        
        
    }
    
    
    public static void createPlatformEvent(List<Guardant_360_Sample__c> sampleRecords, String dmlType){
        
        List<ModifiedRecord__e> publishEvents = new List<ModifiedRecord__e>();
        for(Guardant_360_Sample__c a : sampleRecords){
            ModifiedRecord__e    eve = new ModifiedRecord__e();
            eve.ObjectName__c = 'Guardant_360_Sample__c' ; 
            eve.recordid__C= a.id ; 
            if(dmlType == 'Delete'){
                eve.IsDeleted__c =true;
            }
            else{
                eve.IsDeleted__c =false;
                
            }
            
            publishEvents.add(eve);            
        }
        if(publishEvents.size()>0){
            EventBus.publish(publishEvents);
        }
    }
}