public with sharing class PatientService {


    //Update Match Admin Panel
    public static void updateMatchPanelFields(Set<Id> patientIds) {
        //Query all Match Records for all Accounts
        List<Patient__c> patients = PatientSelector.matchRecordsByPatient(patientIds);
        //For each account, cycle through the match records
        for (Patient__c patient : patients) {
            //if (patient.Match_Records__r.size() == 0)continue;
            String showToCustomerKeys = '';
            String outreachEmailSentKeys = '';
            String outreachEmailReadKeys = '';
            String repliedToOutreachKeys = '';
            String ctaContactKeys = '';
            String lastDitchEmailKeys = '';
            String lastDitchRepliedKeys = '';
            String reachedProviderKeys = '';
            String informedKeys = '';
            String permConnectKeys = '';
            String pharmaPTCKeys = '';
            String screenedKeys = '';
            String enrolledKeys = '';
            String closedKeys = '';
            Date showToCustomerDate;
            Date outreachEmailSent;
            Date outreachEmailRead;
            Date repliedToOutreachEmail;
            Date ctaContactAttempted;
            Date lastDitchEmailSent;
            Date lastDitchEmailReplied;
            Date reachedProvider;
            Date informed;
            Date pharmaPermissionToConnect;
            Date ptcAlertSent;
            Date screenedDate;
            Date enrolledDate;
            Date closedDate;

            for (Match_Record__c matchRecord : patient.Match_Records__r) {
                showToCustomerKeys = buildMatchKeyString('Show_to_Customer__c', showToCustomerKeys, matchRecord);
                outreachEmailSentKeys = buildMatchKeyString('Outreach_Email_Sent__c', outreachEmailSentKeys, matchRecord);
                outreachEmailReadKeys = buildMatchKeyString('Outreach_Email_Read__c', outreachEmailReadKeys, matchRecord);
                repliedToOutreachKeys = buildMatchKeyString('Replied_to_Outreach_Email__c', repliedToOutreachKeys, matchRecord);
                ctaContactKeys = buildMatchKeyString('Contact_Attempted__c', ctaContactKeys, matchRecord);
                lastDitchEmailKeys = buildMatchKeyString('Last_Ditch_Email_Sent__c', lastDitchEmailKeys, matchRecord);
                lastDitchRepliedKeys = buildMatchKeyString('Replied_to_Last_Ditch_Email__c', lastDitchRepliedKeys, matchRecord);
                reachedProviderKeys = buildMatchKeyString('Contact_Achieved__c', reachedProviderKeys, matchRecord);
                informedKeys = buildMatchKeyString('Referred__c', informedKeys, matchRecord);
                permConnectKeys = buildMatchKeyString('Permission_to_Connect_with_Pharma__c', permConnectKeys, matchRecord);
                pharmaPTCKeys = buildMatchKeyString('Pharma_PTC_Alert_Sent__c', pharmaPTCKeys, matchRecord);
                screenedKeys = buildMatchKeyString('Screened__c', screenedKeys, matchRecord);
                enrolledKeys = buildMatchKeyString('Enrolled__c', enrolledKeys, matchRecord);
                closedKeys = buildMatchKeyString('Closed__c', closedKeys, matchRecord);
                showToCustomerDate = getFirstDate('Date_Show_to_Pharma__c', showToCustomerDate, matchRecord);
                outreachEmailSent = getFirstDate('Date_Outreach_Email_Sent__c', outreachEmailSent, matchRecord);
                outreachEmailRead = getFirstDate('Date_Outreach_Email_Read__c', outreachEmailRead, matchRecord);
                repliedToOutreachEmail = getFirstDate('Date_Replied_to_Outreach_Email__c', repliedToOutreachEmail, matchRecord);
                ctaContactAttempted = getFirstDate('Date_Contact_Attempted__c', ctaContactAttempted, matchRecord);
                lastDitchEmailSent = getFirstDate('Date_Last_Ditch_Email_Sent__c', lastDitchEmailSent, matchRecord);
                lastDitchEmailReplied = getFirstDate('Date_Replied_to_Last_Ditch_Email__c', lastDitchEmailReplied, matchRecord);
                reachedProvider = getFirstDate('Date_Contact_Achieved__c', reachedProvider, matchRecord);
                informed = getFirstDate('Date_Referred__c', informed, matchRecord);
                pharmaPermissionToConnect = getFirstDate('Date_Pharma_Permission_to_Connect__c', pharmaPermissionToConnect, matchRecord);
                ptcAlertSent = getFirstDate('Date_PTC_Alert_Sent__c', ptcAlertSent, matchRecord);
                screenedDate = getFirstDate('Date_Screened__c', screenedDate, matchRecord);
                enrolledDate = getFirstDate('Date_Enrolled__c', enrolledDate, matchRecord);
                closedDate = getFirstDate('Date_Closed__c', closedDate, matchRecord);
            }
            patient.Show_to_Customer_Match_Key_s__c = showToCustomerKeys.removeEnd(',');
            patient.Outreach_Email_Sent_Match_Key_s__c = outreachEmailSentKeys.removeEnd(',');
            patient.Outreach_Email_Read_Match_Key_s__c = outreachEmailReadKeys.removeEnd(',');
            patient.Replied_to_Outreach_Email_Match_Key_s__c = repliedToOutreachKeys.removeEnd(',');
            patient.CTA_Contact_Attempted_Match_Key_s__c = ctaContactKeys.removeEnd(',');
            patient.Last_Ditch_Email_Sent_Match_Key_s__c = lastDitchEmailKeys.removeEnd(',');
            patient.Replied_to_Last_Ditch_Email_Match_Key_s__c = lastDitchRepliedKeys.removeEnd(',');
            patient.Reached_Provider_Match_Key_s__c = reachedProviderKeys.removeEnd(',');
            patient.Informed_Match_Key_s__c = informedKeys.removeEnd(',');
            patient.Perm_to_Conn_With_Pharma_Match_Key_s__c = permConnectKeys.removeEnd(',');
            patient.Pharma_PTC_Alert_Match_Key_s__c = pharmaPTCKeys.removeEnd(',');
            patient.Screened_Match_Key_s__c = screenedKeys.removeEnd(',');
            patient.Enrolled_Match_Key_s__c = enrolledKeys.removeEnd(',');
            patient.Closed_Match_Key_s__c = closedKeys.removeEnd(',');
            patient.Show_to_Customer_Date__c = showToCustomerDate;
            patient.Outreach_Email_Sent_Date__c = outreachEmailSent;
            patient.Outreach_Email_Read_Date__c = outreachEmailRead;
            patient.Outreach_Email_Replied_Date__c = repliedToOutreachEmail;
            patient.CTA_Contacted_Attempted_Date__c = ctaContactAttempted;
            patient.Last_Ditch_Email_Sent_Date__c = lastDitchEmailSent;
            patient.Last_Ditch_Email_Replied_Date__c = lastDitchEmailReplied;
            patient.Reached_Provider_Date__c = reachedProvider;
            patient.Informed_Date__c = informed;
            patient.Permission_to_Connect_with_Pharma_Date__c = pharmaPermissionToConnect;
            patient.Pharma_PTC_Alert_Date__c = ptcAlertSent;
            patient.Screened_Date__c = screenedDate;
            patient.Enrolled_Date__c = enrolledDate;
            patient.Closed_Date__c = closedDate;

        }

        update patients;
    }

    private static String buildMatchKeyString(String fieldName, String matchKeyString, Match_Record__c matchRecord) {
        Boolean fieldChecked = (Boolean) matchRecord.get(fieldName);
        if (fieldChecked) {
            matchKeyString += (String) matchRecord.get('Match_Key__c') + ',';
        }
        return matchKeyString;
    }

    private static Date getFirstDate(String fieldName, Date currentDate, Match_Record__c matchRecord) {
        Map<String, Schema.DescribeFieldResult> finalMap =
                Utils.getFieldMetaData(Match_Record__c.getSObjectType().getDescribe(), new Set<String>{
                        fieldName
                });
        Date matchRecordDate;
        if (finalMap.get(fieldName).getType() == Schema.DisplayType.DATE) {
            matchRecordDate = (Date) matchRecord.get(fieldName);
        } else if (finalMap.get(fieldName).getType() == Schema.DisplayType.DATETIME) {
            matchRecordDate = Date.valueOf(getLocalDateTime((Datetime) matchRecord.get(fieldName)));
        }
        if (matchRecordDate != null) {
            if (currentDate == null || matchRecordDate < currentDate) {
                return matchRecordDate;
            }
        }
        return currentDate;
    }

    public static Datetime getLocalDateTime(Datetime g) {
        if (g == null){
            return null;
        }
        Datetime l = g.date();
        l = l.addHours(g.hour());
        l = l.addMinutes(g.minute());
        l = l.addSeconds(g.second());
        return l;
    }

}