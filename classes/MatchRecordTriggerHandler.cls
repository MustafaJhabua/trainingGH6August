public class MatchRecordTriggerHandler {


    /******Handles the setting of the Sample ID that is passed from Portal******/
    public static void setSampleID(List<Match_Record__c> mrList) {
        for (Match_Record__c mr : mrList) {
            //set string and call Portal API for rest of info
            String match_id = mr.Match_ID__c;
            System.debug(match_id);
            //Removed to put in batch - PortalQuery.portalGet(match_id);

            //if the field that portal passes gets populated, find matching sample
            if (mr.Portal_Sample_ID__c != null) {
                Guardant_360_Sample__c sample = [
                        SELECT Id
                        FROM Guardant_360_Sample__c
                        WHERE Name = :mr.Portal_Sample_ID__c
                        LIMIT 1
                ];
                //set Sample lookup and update Match Record
                mr.Sample_ID__c = sample.Id;
            }
        }
    }

    public static void onAfterUpdate(List<Match_Record__c> newRecords) {
        updateMatchPanelFields(newRecords);
    }

    public static void onAfterDelete(List<Match_Record__c> deletedRecords) {
        updateMatchPanelFields(deletedRecords);
    }

    public static void updateMatchPanelFields(List<Match_Record__c> records) {
        Set<Id> patientIds = new Set<Id>();
        for (Match_Record__c mr : records) {
            patientIds.add(mr.Patient_ID__c);
        }
        PatientService.updateMatchPanelFields(patientIds);
    }
    public static void onBeforeUpdate(List<Match_Record__c> mrList, Map <Id, Match_Record__c> oldMR) {
        if (mrList.size() == 1) {
            apiCall(mrList, oldMR);
            // Added by siva for testing the do not contact functionality
            apiCallNew(mrList, oldMR);
        }
    }

    // Added by siva for testing
    public static void apiCallNew(List<Match_Record__c> mrList, Map <Id, Match_Record__c> oldMR) {
        List<String> matchRecordTokens = new List<String>();
        string status = '';
        string subStatus = '';
        string subStatusReason = '';
        String basePortalAPI = ConfigService.matchPortalEndpoint + 'api/match_service/matches?match_id=';
        String authToken = '&token=' + ConfigService.matchPortalToken;
        List <String> API = new List <String>();
        for (Match_Record__c mr : mrList) {

            // Added the below condition for ENt-7616 for the second scenario “DO NOT CONTACT” MRs
            if (mr.Enrollment_Status__c == 'Closed' &&
                    mr.Enrollment_Status__c != oldMR.get(mr.Id).Enrollment_Status__c && mr.Enrollment_Sub_Status__c == 'Provider Refusal' && mr.Enrollment_Sub_Status__c != oldMR.get(mr.Id).Enrollment_Sub_Status__c
                    && mr.Sub_Status_Reason__c == 'Do Not Contact' && mr.Sub_Status_Reason__c != oldMR.get(mr.Id).Sub_Status_Reason__c) {

                //auth token from portal (the & is just to tie the string together)

                //base Portal API
                status = EncodingUtil.urlEncode('Closed', 'UTF-8');
                subStatus = EncodingUtil.urlEncode('Provider Refusal', 'UTF-8');
                subStatusReason = EncodingUtil.urlEncode('Do Not Contact', 'UTF-8');
                API.add('enrollment_status' + status);
                API.add('enrollment_status_sub_status' + subStatus);
                API.add('enrollment_status_sub_reason' + subStatusReason);

            }

            //  Added the below condition for ENt-7616 for the first scenario  “International Sample” MRs
            if (mr.Show_to_Customer__c != oldMR.get(mr.Id).Show_to_Customer__c) {
                if (mr.Show_to_Customer__c == true) {
                    API.add('show_to_customer=Yes');
                }
                if (mr.Show_to_Customer__c == false) {
                    API.add('show_to_customer=No');
                }

            }

            //  Added the below condition for ENt-7616 for the third scenario  “Emailed” MRs
         /*   if (mr.Enrollment_Sub_Status__c != oldMR.get(mr.Id).Enrollment_Sub_Status__c) {
                if (mr.Enrollment_Sub_Status__c == 'Emailed') {
                    API.add('enrollment_status_sub_status=Emailed');
                }


            }*/

            basePortalAPI = basePortalAPI + mr.Match_ID__c + authToken + '&';

            String apiString = String.join(API, '&');
            String postAPI = basePortalAPI + apiString;
            System.debug('basePortalAPI = ' + basePortalAPI);

            System.debug('postAPI = ' + postAPI);
            matchRecordTokens.add(postAPI);
        }
//replaced the below with the following method
        if(API.size() > 0){
        sendMatchRecordTokens(matchRecordTokens);
        }
//        if (matchRecordTokens.size() > 0 && !System.isQueueable() && Limits.getQueueableJobs() == 0) {
//            //Send to Queueable
//            System.enqueueJob(new QUEUEABLE_PostMatchRecordUpdates(matchRecordTokens));
//        }
    }


    /****Create API to Portal when Match Record updated in SFDC*****/
    public static void apiCall(List<Match_Record__c> mrList, Map <Id, Match_Record__c> oldMR) {
        List<String> matchRecordTokens = new List<String>();
        for (Match_Record__c mr : mrList) {
            // Do not do this if the Closest_Trial_Site__c was updated
            if (mr.Closest_Trial_Site__c != oldMR.get(mr.Id).Closest_Trial_Site__c) {
                continue;
            }
            if (mr.Last_Match_API_Update__c == oldMR.get(mr.Id).Last_Match_API_Update__c) {

                List <String> API = new List <String>();
                //auth token from portal (the & is just to tie the string together)
                String authToken = '&token=' + ConfigService.matchPortalToken;
                //base Portal API
                String basePortalAPI = ConfigService.matchPortalEndpoint + 'api/match_service/match/update?match_id=' + mr.Match_ID__c + authToken + '&';
                System.debug('basePortalAPI = ' + basePortalAPI);


                //Check values on fields and add to API if they have changed
                if (mr.Enrollment_Sub_Status__c != oldMR.get(mr.Id).Enrollment_Sub_Status__c) {
                    if (mr.Enrollment_Sub_Status__c == null) {
                        API.add('enrollment_status_sub_status');
                    } else {
                        String ess = mr.Enrollment_Sub_Status__c;
                        ess = EncodingUtil.urlEncode(ess, 'UTF-8');
                        API.add('enrollment_status_sub_status=' + ess);
                    }
                }
                System.debug(API);
                if (mr.Sub_Status_Reason__c != oldMR.get(mr.Id).Sub_Status_Reason__c) {
                    if (mr.Sub_Status_Reason__c == null) {
                        API.add('enrollment_status_sub_reason');
                    } else {
                        String ssr = mr.Sub_Status_Reason__c;
                        ssr = EncodingUtil.urlEncode(ssr, 'UTF-8');
                        API.add('enrollment_status_sub_reason=' + ssr);
                    }
                }
                System.debug(API);
                if (mr.Guardant_Notes__c != oldMR.get(mr.Id).Guardant_Notes__c) {
                    if (mr.Guardant_Notes__c == null) {
                        API.add('guardant_notes');
                    } else {
                        String gNotes = mr.Guardant_Notes__c;
                        gNotes = EncodingUtil.urlEncode(gNotes, 'UTF-8');
                        API.add('guardant_notes=' + gNotes);
                    }
                }
                System.debug(API);
                if (mr.Permission_to_Connect_with_Pharma__c != oldMR.get(mr.Id).Permission_to_Connect_with_Pharma__c) {
                    if (mr.Permission_to_Connect_with_Pharma__c == true) {
                        API.add('permission_to_connect_with_pharma=Yes');
                    }
                    if (mr.Permission_to_Connect_with_Pharma__c == false) {
                        API.add('permission_to_connect_with_pharma=No');
                    }
                }
                System.debug(API);
                if (mr.Referred__c != oldMR.get(mr.Id).Referred__c) {
                    if (mr.Referred__c == true) {
                        API.add('referred=Yes');
                    }
                    if (mr.Referred__c == false) {
                        API.add('referred=No');
                    }
                }
                System.debug(API);
                if (mr.Client_Notes__c != oldMR.get(mr.Id).Client_Notes__c) {
                    if (mr.Client_Notes__c == null) {
                        API.add('client_notes');
                    } else {
                        String cNotes = mr.Client_Notes__c;
                        cNotes = EncodingUtil.urlEncode(cNotes, 'UTF-8');
                        API.add('client_notes=' + cNotes);
                    }
                }
                System.debug(API);
                if (mr.Enrollment_Status__c != oldMR.get(mr.Id).Enrollment_Status__c) {
                    if (mr.Enrollment_Status__c == null) {
                        API.add('enrollment_status');
                    } else {
                        String es = mr.Enrollment_Status__c;
                        es = EncodingUtil.urlEncode(es, 'UTF-8');
                        API.add('enrollment_status=' + es);
                    }
                }
                System.debug(API);
                if (mr.Match_Priority__c != oldMR.get(mr.Id).Match_Priority__c) {
                    if (mr.Match_Priority__c == null) {
                        API.add('priority');
                    } else {
                        String mp = mr.Match_Priority__c;
                        mp = EncodingUtil.urlEncode(mp, 'UTF-8');
                        API.add('priority=' + mp);
                    }
                }
                System.debug(API);

                if (mr.Match_Status__c != oldMR.get(mr.Id).Match_Status__c) {
                    if (mr.Match_Status__c == null) {
                        API.add('match_status');
                    } else {
                        String ms = mr.Match_Status__c;
                        ms = EncodingUtil.urlEncode(ms, 'UTF-8');
                        API.add('match_status=' + ms);
                    }
                }
                System.debug(API);
                if (mr.Show_to_Customer__c != oldMR.get(mr.Id).Show_to_Customer__c) {
                    if (mr.Show_to_Customer__c == true) {
                        API.add('show_to_customer=Yes');
                    }
                    if (mr.Show_to_Customer__c == false) {
                        API.add('show_to_customer=No');
                    }
                }
                System.debug(API);
                if (mr.Date_of_1st_Contact__c != oldMR.get(mr.Id).Date_of_1st_Contact__c) {
                    if (mr.Date_of_1st_Contact__c == null) {
                        API.add('date_of_first_contact');
                    } else {
                        Datetime dfc = mr.Date_of_1st_Contact__c;
                        String dfc1 = dfc.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                        dfc1 = dfc1 + 'GMT';
                        dfc1 = EncodingUtil.urlEncode(dfc1, 'UTF-8');
                        API.add('date_of_first_contact=' + dfc1);
                    }
                }
                System.debug(API);
                if (mr.Date_of_Last_Contact__c != oldMR.get(mr.Id).Date_of_Last_Contact__c) {
                    if (mr.Date_of_Last_Contact__c == null) {
                        API.add('date_of_last_contact');
                    } else {
                        Datetime dlc = mr.Date_of_Last_Contact__c;
                        String dlc1 = dlc.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                        dlc1 = dlc1 + 'GMT';
                        dlc1 = EncodingUtil.urlEncode(dlc1, 'UTF-8');
                        API.add('date_of_last_contact=' + dlc1);
                    }
                }
                System.debug(API);
                if (mr.Date_Closed__c != oldMR.get(mr.Id).Date_Closed__c) {
                    if (mr.Date_Closed__c == null) {
                        API.add('date_closed');
                    } else {
                        Datetime dc = mr.Date_Closed__c;
                        String dc1 = dc.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                        dc1 = dc1 + 'GMT';
                        dc1 = EncodingUtil.urlEncode(dc1, 'UTF-8');
                        API.add('date_closed=' + dc1);
                    }
                }
                System.debug(API);
                if (mr.Date_Enrolled__c != oldMR.get(mr.Id).Date_Enrolled__c) {
                    if (mr.Date_Enrolled__c == null) {
                        API.add('date_enrolled');
                    } else {
                        Datetime de = mr.Date_Enrolled__c;
                        String de1 = de.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                        de1 = de1 + 'GMT';
                        de1 = EncodingUtil.urlEncode(de1, 'UTF-8');
                        API.add('date_enrolled=' + de1);
                    }
                }
                System.debug(API);
                if (mr.Date_Ineligible__c != oldMR.get(mr.Id).Date_Ineligible__c) {
                    if (mr.Date_Ineligible__c == null) {
                        API.add('date_ineligible');
                    } else {
                        Datetime di = mr.Date_Ineligible__c;
                        String di1 = di.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                        di1 = di1 + 'GMT';
                        di1 = EncodingUtil.urlEncode(di1, 'UTF-8');
                        API.add('date_ineligible=' + di1);
                    }
                }
                System.debug(API);
                if (mr.Date_of_Failed_Screening__c != oldMR.get(mr.Id).Date_of_Failed_Screening__c) {
                    if (mr.Date_of_Failed_Screening__c == null) {
                        API.add('date_failed_screening');
                    } else {
                        Datetime dfs = mr.Date_of_Failed_Screening__c;
                        String dfs1 = dfs.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                        dfs1 = dfs1 + 'GMT';
                        dfs1 = EncodingUtil.urlEncode(dfs1, 'UTF-8');
                        API.add('date_failed_screening=' + dfs1);
                    }
                }
                System.debug(API);
                if (mr.Date_Referred__c != oldMR.get(mr.Id).Date_Referred__c) {
                    if (mr.Date_Referred__c == null) {
                        API.add('date_referred');
                    } else {
                        Datetime dr = mr.Date_Referred__c;
                        String dr1 = dr.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                        dr1 = dr1 + 'GMT';
                        dr1 = EncodingUtil.urlEncode(dr1, 'UTF-8');
                        API.add('date_referred=' + dr1);
                    }
                }
                System.debug(API);
                if (mr.Send_POD__c != oldMR.get(mr.Id).Send_POD__c) {
                    if (mr.Send_POD__c == true) {
                        API.add('referral_pod=null');
                        if (mr.Send_POD_No_Email__c == true) {
                            API.add('skip_email=true');
                        }
                        API.add('referral_custom_signature=' + mr.Custom_Signature__c);
                        if (mr.X1st_Paragraph__c != null) {
                            String paragraph = mr.X1st_Paragraph__c;
                            paragraph = EncodingUtil.urlEncode(paragraph, 'UTF-8');
                            API.add('referral_custom_intro=' + paragraph);
                        }
                    }
                }
                System.debug('%%% This is where POD Stuff should be' + API);

                //format API string
                String apiString = String.join(API, '&');
                String postAPI = basePortalAPI + apiString;
                System.debug('postAPI = ' + postAPI);

                //if the final API has changed (and fields will be updated in Portal), post mr.Token and callout
                if (basePortalAPI != postAPI) {
                    matchRecordTokens.add(postAPI);
                    System.debug('Tokens to add: ' + postAPI);
                }
            } else {
                break;
            }

        }
        System.debug('tokens' + matchRecordTokens);
        sendMatchRecordTokens(matchRecordTokens);
    }

    public static void sendMatchRecordTokens(List<String> matchRecordTokens) {
        if (matchRecordTokens.size() > 0 && !System.isQueueable() && Limits.getQueueableJobs() == 0) {
            //Send to Queueable
            System.enqueueJob(new QUEUEABLE_PostMatchRecordUpdates(matchRecordTokens));
        } else {
            for (String token : matchRecordTokens) {
                if (System.isFuture() || System.isQueueable() || System.isBatch()) {
                    QUEUEABLE_PostMatchRecordUpdates.apiCallout(token);
                } else {
                    apiCallout(token);
                }
            }
        }
    }


    /****Callout to update Portal API*****/
    @Future(Callout=true)
    public static void apiCallout(String postAPI) {
        //check string was passed
        System.debug('Im being called = ' + postAPI);
        MatchRecordTriggerHelper.inFutureContext = TRUE;
        //post URL to portal
        try {
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http http = new Http();

            req.setEndpoint(postAPI);
            req.setMethod('POST');
            req.setBody('test');

            res = http.send(req);
            System.debug('If you get 200 response, you are good!  Response: ' + res.getStatusCode());
        } catch (System.CalloutException e) {
            System.debug('Callout error: ' + e);
        }
    }
}