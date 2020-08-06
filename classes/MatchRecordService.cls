public without sharing class MatchRecordService {
    private static final Map<String, String> ALT_TYPE_MAP = new Map<String, String>{
            'snv' => 'SNV',
            'cnv' => 'amplification',
            'indel' => 'indel',
            'fusion' => 'fusion'
    };
    public static final List<String> VOWELS = new List<String>{
            'a', 'e', 'i', 'o', 'u'
    };

    public Match_Record__c mRecord { get; set; }
    public String portalJsonResponse { get; set; }
    private Id studyId;

    public Match_Record__c updateMatchRecordFromPortal() {
        MatchRecordResponse response = MatchRecordResponse.parse(portalJsonResponse);
        mRecord.Match_Key__c = response.match_key;
        mRecord.Enrollment_Status__c = response.enrollment_status;
        mRecord.Enrollment_Sub_Status__c = response.enrollment_status_sub_status;
        mRecord.Sub_Status_Reason__c = response.enrollment_status_sub_reason;
        mRecord.Match_Algorithm_Version_Number__c = response.match_algorithm_version;
        mRecord.Guardant_Notes__c = response.guardant_notes;
        mRecord.Client_Notes__c = response.client_notes;
        mRecord.Referred__c = yesNoToBoolean(response.referred);
        mRecord.Permission_to_Connect_with_Pharma__c = yesNoToBoolean(response.permission_to_connect_with_pharma);
        mRecord.Match_Priority__c = response.priority;
        mRecord.Competing_Trials__c = response.competing_trials;
        mRecord.Trial_Name__c = response.trial_id;
        mRecord.Ordering_Practice_Site_Type__c = response.ordering_practice_site_type;
        mRecord.Match_Status__c = response.match_status;
        mRecord.Pharma_Company__c = response.pharma_company_id;
        mRecord.Show_to_Customer__c = yesNoToBoolean(response.show_to_customer);
        mRecord.Date_of_1st_Contact__c = response.date_of_first_contact;
        mRecord.Date_Closed__c = response.date_closed;
        mRecord.Date_Identified__c = response.date_identified;
        mRecord.Date_of_Last_Contact__c = response.date_of_last_contact;
        mRecord.Date_Enrolled__c = response.date_enrolled;
        mRecord.Date_Ineligible__c = response.date_ineligible;
        mRecord.Date_of_Failed_Screening__c = response.date_failed_screening;
        mRecord.Date_Referred__c = response.date_referred;
        if (response.closest_trial_sites != null) {
            Boolean closestTrialSiteChanged = mRecord.Closest_Trial_Site__c != response.closest_trial_sites.pharma_site_id;
            mRecord.Closest_Trial_Site__c = response.closest_trial_sites.pharma_site_id;

            if (closestTrialSiteChanged) {
                Study_Site__c trialSite = findTrialSiteId(mRecord.Closest_Trial_Site__c, mRecord.Trial_Name__c);
                if (trialSite != null) {
                    mRecord.Closest_Trial_Site2__c = trialSite.Id;
                }
            }
        }

        List <String> alterations = new List <String>();
        String qualifyingGenes = '';
        Integer geneCount = response.qualifying_target_alts.size();
        String andSeparator = geneCount == 2 ? ' and ' : ', and ';
        for (MatchRecordResponse.QualifyingTargetAlt alt : response.qualifying_target_alts) {
            String altString = alt.alt_string;
            String gene = alt.gene_name;
            String altType = ALT_TYPE_MAP.get(alt.alt_type);
            String article = (beginsWithVowel(gene)) ? 'an ' : 'a ';
            String fullGeneName = article + gene + ' ' + altType;
            alterations.add(altString);
            if (qualifyingGenes == '') {
                qualifyingGenes = fullGeneName;
            } else if (geneCount > 1) {
                qualifyingGenes += ', ' + fullGeneName;
            } else {
                qualifyingGenes += andSeparator + fullGeneName;
            }
            geneCount = geneCount - 1;
        }
        String alterationString = String.join(alterations, ', ');
        mRecord.Qualifying_Target_Alterations__c = alterationString;
        mRecord.Qualifying_Target_Genes__c = qualifyingGenes;
        mRecord.Last_Match_API_Update__c = System.now();
        mRecord.Batch_Check__c = false;
        MatchRecordTriggerHelper.inFutureContext = true;
        update mRecord;
        return mRecord;
    }

    public static Boolean yesNoToBoolean(String yesNo) {
        if (yesNo == 'Yes') {
            return true;
        }
        if (yesNo == 'No') {
            return false;
        }
        return null;
    }

    public static Boolean beginsWithVowel(String phrase) {
        String firstLetter = phrase.substring(0, 1).toLowerCase();
        Boolean result = VOWELS.contains(firstLetter);
        return result;
    }

    public void assignStudyPageURL() {

        StudyPageMessage.Patient patient = new StudyPageMessage.Patient();
        patient.match_key = mRecord.Match_Key__c;
        patient.patient_initials = mRecord.Patient_Initials__c;
        patient.qualifying_target_alteration = mRecord.Qualifying_Target_Alterations__c;
        patient.final_report_date = mRecord.Final_Report_Date__c;
        patient.cancer_type = mRecord.Cancer_Type_Lower_Case__c;
        patient.portal_url = mRecord.Portal_Link_For_MD_text__c;

        StudyPageMessage.Ordering_physician ordering_physician = new StudyPageMessage.Ordering_physician();
        ordering_physician.first_name = mRecord.MD_First_Name__c;
        ordering_physician.last_name = mRecord.MD_Last_Name__c;
        ordering_physician.email = mRecord.Physician_Email__c;
        ordering_physician.phone = mRecord.Physician_phone__c;
        ordering_physician.practice_name = mRecord.Ordering_Practice_Name__r.Name;
        StudyPageMessage.Address opAddress = new StudyPageMessage.Address();
        opAddress.street = mRecord.Practice_Address__c;
        opAddress.city = mRecord.Practice_City__c;
        opAddress.state = mRecord.Practice_State__c;
        opAddress.zip = mRecord.Practice_Zip__c;
        ordering_physician.address = opAddress;

        StudyPageMessage.Trial trial = new StudyPageMessage.Trial();
        trial.name = mRecord.Trial_Name__r.Study_Title__c;
        trial.nct_id = mRecord.Trial_Name__r.NCT_Identifier__c;
        trial.study_code = mRecord.Trial_Name__r.Trial_Code__c;

        StudyPageMessage.Trial_site trial_site = new StudyPageMessage.Trial_site();
        trial_site.name = mRecord.Connected_Trial_Site__r.Site__r.Name;
        StudyPageMessage.Address tsAddress = new StudyPageMessage.Address();
        tsAddress.street = mRecord.Connected_Trial_Site_Address__c;
        tsAddress.city = mRecord.Connected_Trial_Site_City__c;
        tsAddress.state = mRecord.Connected_Trial_Site_State__c;
        tsAddress.zip = mRecord.Connected_Trial_Site_Zip_Code__c;
        trial_site.address = tsAddress;

        StudyPageMessage message = new StudyPageMessage();
        message.patient = patient;
        message.ordering_physician = ordering_physician;
        message.trial = trial;
        message.trial_site = trial_site;
        message.trial_site_pis = fetchTrialSitePis();
        List<StudyPageMessage.Trial_site_contacts> tsContacts = fetchTrialSiteContacts();
        if (tsContacts == null || tsContacts.size() == 0) {
            String errorMessage = 'Yuzu Exception: There must be at least one Trial Site Contact or Study Manager for Pharma';
            FeedItem chatterPost = createFeedMessage(mRecord.Id, errorMessage);
            insert chatterPost;
            if (!Trigger.isExecuting && !System.isFuture()) {
                throw new YuzuException(errorMessage);
            }
            return;
        }
        message.trial_site_contacts = tsContacts;

        HttpResponse resp = message.sendMessage(message);
        //parse response
        System.debug('==whole response: ' + resp);
        StudyPageMessage.Response response = (StudyPageMessage.Response) System.JSON.deserialize(resp.getBody(), StudyPageMessage.Response.class);
        System.debug('==parsed response: ' + response);
        if (response.status != 'success') {
            String errorMessage = 'Yuzu Exception: ' + response.errors;
            FeedItem chatterPost = createFeedMessage(mRecord.Id, errorMessage);
            insert chatterPost;
            if (!Trigger.isExecuting && !System.isFuture()) {
                throw new YuzuException(errorMessage);
            }
        }
        if (response.data.scheduling_url != null) {
            mRecord.YuzuSchedulingLink__c = response.data.scheduling_url;
        }
        update mRecord;
    }

    public List<StudyPageMessage.Trial_site_contacts> fetchTrialSiteContacts() {
        Study_Site__c site = queryTrialSiteContacts();
        System.debug('=== Site Contacts: ' + site);
        if (site == null) {
            return null;
        }
        List<Studies_Sites_Contact__c> trialSiteContacts = new List<Studies_Sites_Contact__c>();
        List<StudyPageMessage.Trial_site_contacts> results = new List<StudyPageMessage.Trial_site_contacts>();
        if (site.PTC_Connection_Preference__c == 'Connect to Trial Site') {
            trialSiteContacts = site.Studies_Sites_Contacts__r;
            if (trialSiteContacts != null) {
                for (Studies_Sites_Contact__c con : trialSiteContacts) {
                    StudyPageMessage.Trial_site_contacts tsContact = new StudyPageMessage.Trial_site_contacts();
                    tsContact.first_name = con.Contact__r.FirstName;
                    tsContact.last_name = con.Contact__r.LastName;
                    tsContact.email = con.Email__c;
                    tsContact.phone = con.Contact__r.Phone;
                    results.add(tsContact);
                }
            }
        } else {
            //check for study managers
            studyId = site.Study__c;
            List<Studies_Study_Manager__c> studyManagers = queryStudyManagers();
            System.debug('===Study Managers: ' + studyManagers);
            if (studyManagers != null) {
                for (Studies_Study_Manager__c studyManager : studyManagers) {
                    StudyPageMessage.Trial_site_contacts tsContact = new StudyPageMessage.Trial_site_contacts();
                    tsContact.first_name = studyManager.Contact__r.FirstName;
                    tsContact.last_name = studyManager.Contact__r.LastName;
                    tsContact.email = studyManager.Contact__r.Email;
                    tsContact.phone = studyManager.Contact__r.Phone;
                    results.add(tsContact);
                }
            }

        }

        return results;
    }

    public List<StudyPageMessage.Trial_site_pis> fetchTrialSitePis() {
        //query connected trial site contacts where Site Contact Type = "Principal Investigator"
        List<Studies_Sites_Contact__c> principalInvestigators = queryPrincipalInvestigators();
        if (principalInvestigators == null || principalInvestigators.size() == 0) {
            String errorMessage = 'Yuzu Exception: There must be at least one Principal Investigator';
            FeedItem chatterPost = createFeedMessage(mRecord.Id, errorMessage);
            insert chatterPost;
            if (!Trigger.isExecuting && !System.isFuture()) {
                throw new YuzuException(errorMessage);
            }
            return null;
        }
        List<StudyPageMessage.Trial_site_pis> results = new List<StudyPageMessage.Trial_site_pis>();
        for (Studies_Sites_Contact__c pi : principalInvestigators) {
            StudyPageMessage.Trial_site_pis piRecord = new StudyPageMessage.Trial_site_pis();
            piRecord.first_name = pi.Contact__r.FirstName;
            piRecord.last_name = pi.Contact__r.LastName;
            piRecord.npi = pi.Contact__r.Actual_NPI__r.Name;
            results.add(piRecord);
        }
        return results;
    }

    public List<Studies_Sites_Contact__c> queryPrincipalInvestigators() {
        List<Study_Site__c> trialsSite = [
                SELECT Id, (
                        SELECT Id,
                                Contact__r.FirstName,
                                Contact__r.LastName,
                                Contact__r.Email,
                                Contact__r.Phone,
                                Email__c,
                                Contact__r.Actual_NPI__r.Name
                        FROM Studies_Sites_Contacts__r
                        WHERE Site_Contact_Type__c = 'Principal Investigator'
                )
                FROM Study_Site__c
                WHERE Id = :mRecord.Connected_Trial_Site__c
        ];
        if (trialsSite.size() == 0) {
            return null;
        }
        return trialsSite[0].Studies_Sites_Contacts__r;
    }

    public Study_Site__c queryTrialSiteContacts() {
        List<Study_Site__c> trialsSite = [
                SELECT Id, PTC_Connection_Preference__c, Study__c, (
                        SELECT Id,
                                Contact__r.FirstName,
                                Contact__r.LastName,
                                Contact__r.Email,
                                Contact__r.Phone,
                                Email__c,
                                Site_Contact_Type__c
                        FROM Studies_Sites_Contacts__r
                        WHERE Email__c != NULL
                        AND PTC_Connection_Opt_In__c = TRUE
                )
                FROM Study_Site__c
                WHERE Id = :mRecord.Connected_Trial_Site__c
        ];
        if (trialsSite.size() == 0) {
            return null;
        }
        return trialsSite[0];

    }

    public List<Studies_Study_Manager__c> queryStudyManagers() {
        List<Studies_Study_Manager__c> studyManagers = [
                SELECT Id, Contact__r.FirstName, Contact__r.LastName, Contact__r.Email, Contact__r.Phone
                FROM Studies_Study_Manager__c
                WHERE Study__c = :studyId
                AND PTC_Connection_Opt_In__c = TRUE
        ];
        return studyManagers;
    }

    private static FeedItem createFeedMessage(Id recordId, String feedMessage) {
        FeedItem post = new FeedItem();
        post.ParentId = recordId;
        post.Body = feedMessage;
        return post;
    }

    //Return a Map of <Match Record ID, Study Site Id> Send a Map of Trial Site Account Ids and Trial Ids
    public static Map<Id, Id> findTrialSiteIds(List<Match_Record__c> matchRecords) {
        Map<Id, Id> accountsAndTrialIds = new Map<Id, Id>();
        for (Match_Record__c matchRecord : matchRecords) {
            accountsAndTrialIds.put(matchRecord.Closest_Trial_Site__c, matchRecord.Trial_Name__c);
        }
        List<Study_Site__c> trialSites = [
                SELECT Id, Site__c, Study__c
                FROM Study_Site__c
                WHERE Site__c IN :accountsAndTrialIds.keySet() AND Study__c IN :accountsAndTrialIds.values()
        ];
        Map<String, Id> trialSitesMap = new Map<String, Id>();
        for (Study_Site__c trialSite : trialSites) {
            trialSitesMap.put(String.valueOf(trialSite.Site__c) + String.valueOf(trialSite.Study__c), trialSite.Id);
        }

        Map<Id, Id> results = new Map<Id, Id>();
        for (Match_Record__c matchRecord : matchRecords) {
            results.put(matchRecord.Id, trialSitesMap.get(String.valueOf(matchRecord.Closest_Trial_Site__c) + String.valueOf(matchRecord.Trial_Name__c)));
        }
        return results;
    }


    public static Study_Site__c findTrialSiteId(Id trialSiteAccountId, Id trial) {
        List<Study_Site__c> trialSites = [
                SELECT Id
                FROM Study_Site__c
                WHERE Site__c = :trialSiteAccountId AND Study__c = :trial
                LIMIT 1
        ];
        return (trialSites.size() == 1) ? trialSites.get(0) : null;
    }
}