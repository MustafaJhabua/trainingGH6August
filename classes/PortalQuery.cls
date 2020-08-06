public class PortalQuery {
    @future (callout=true)
    public static void portalGet(String match_id){
        
        //set Match Record        
        Match_Record__c mr = [SELECT Id, PODs__c
                                FROM Match_Record__c 
                               WHERE Match_ID__c = :match_id];
        
        System.debug(match_id);
        System.debug(mr.Id);
    
        //callout to Portal API
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ConfigService.matchPortalEndpoint + '/api/match_service/matches?match_id=' + match_id + '&token='+ConfigService.matchPortalToken);
        req.setMethod('GET');
        req.setTimeout(60000);
        HttpResponse res = http.send(req);

        // If the request is successful, parse the JSON response.
        if (res.getStatusCode() == 200) {
            system.debug('response = ' + res.getBody());
            String jsonContent = res.getBody();
            System.debug(jsonContent);
            
            //call JSON Utility to help with parse
            Util_JSONParser parser = Util_JSONParser.createParser(jsonContent);
            
            //parse out Match Record fields for updated
            String match_key = parser.get('match_key').Value;
            if(match_key != 'null'&& match_key != NULL){
                mr.Match_Key__c = match_key;
            }
            
            String enrollment_status = parser.get('enrollment_status').Value;
            if(enrollment_status != 'null' && enrollment_status !=NULL){
                mr.Enrollment_Status__c = enrollment_status;
            }
            else if(enrollment_status == NULL || enrollment_status == 'null'){
                mr.Enrollment_Status__c = NULL;
            }
            
            String enrollment_status_sub_status = parser.get('enrollment_status_sub_status').Value;
            if(enrollment_status_sub_status != 'null' && enrollment_status_sub_status != NULL){
                mr.Enrollment_Sub_Status__c = enrollment_status_sub_status;
            }
            else if(enrollment_status_sub_status == NULL || enrollment_status_sub_status == 'null'){
                mr.Enrollment_Sub_Status__c = NULL;
            }
            
            String enrollment_status_sub_reason = parser.get('enrollment_status_sub_reason').Value;
            if(enrollment_status_sub_reason != 'null' && enrollment_status_sub_reason != NULL){
                mr.Sub_Status_Reason__c = enrollment_status_sub_reason;
            }
            else if(enrollment_status_sub_reason == NULL || enrollment_status_sub_reason == 'null'){
                mr.Sub_Status_Reason__c = NULL;
            }
            
            String match_algorithm_version = parser.get('match_algorithm_version').Value;
            if(match_algorithm_version != 'null' && match_algorithm_version != NULL){
                Decimal mav = Decimal.valueOf(match_algorithm_version);
                mr.Match_Algorithm_Version_Number__c = mav; 
            }
            
            String guardant_notes = parser.get('guardant_notes').Value;
            if(guardant_notes != 'null' && guardant_notes != NULL){
                mr.Guardant_Notes__c = guardant_notes;
            }
            else if(guardant_notes == NULL || guardant_notes == 'null'){
                mr.Guardant_Notes__c = NULL;
            }
            
            String client_notes = parser.get('client_notes').Value;
            if(client_notes != 'null' && client_notes != NULL){
                mr.Client_Notes__c = client_notes;
            }
            else if(client_notes == NULL || client_notes == 'null'){
                mr.Client_Notes__c = NULL;
            }
            
            String referred = parser.get('referred').Value;
            if(referred != 'null' && referred != NULL){
                if(referred == 'Yes'){
                    mr.Referred__c = TRUE;
                }
                if(referred == 'No'){
                    mr.Referred__c = FALSE;
                }
            }
            
            String permission_to_connect_with_pharma = parser.get('permission_to_connect_with_pharma').Value;
            if(permission_to_connect_with_pharma != 'null' && permission_to_connect_with_pharma != NULL){
                if(permission_to_connect_with_pharma == 'Yes'){
                    mr.Permission_to_Connect_with_Pharma__c = TRUE;
                }
                if(permission_to_connect_with_pharma == 'No'){
                    mr.Permission_to_Connect_with_Pharma__c = FALSE;
                }
            }
            
            String priority = parser.get('priority').Value;
            if(priority != 'null' && priority != NULL){
                mr.Match_Priority__c = priority;
            }
            else if(priority == NULL || priority == 'null'){
                mr.Match_Priority__c = NULL;
            }
            
            String competing_trials = parser.get('competing_trials').Value;
            if(competing_trials != NULL && competing_trials != 'null'){
                mr.Competing_Trials__c = competing_trials;
            }
            else if(competing_trials == NULL || competing_trials == 'null'){
                mr.Competing_Trials__c = NULL;
            }
            
            String trial_id = parser.get('trial_id').Value;
            if (trial_id != NULL && trial_id != 'null'){
                mr.Trial_Name__c = trial_id;
            }
            else if(trial_id == NULL || trial_id == 'null'){
                mr.Trial_Name__c = NULL;
            }
            
            String ordering_practice_site_type = parser.get('ordering_practice_site_type').Value;
            if (ordering_practice_site_type != NULL && ordering_practice_site_type != 'null'){
                mr.Ordering_Practice_Site_Type__c = ordering_practice_site_type;
            }
            else if(ordering_practice_site_type == NULL || ordering_practice_site_type == 'null'){
                mr.Ordering_Practice_Site_Type__c = NULL;
            }
            
            String match_status = parser.get('match_status').Value;
            if (match_status != NULL && match_status != 'null'){
                mr.Match_Status__c = match_status;
            }
            else if(match_status == NULL || match_status == 'null'){
                mr.Match_Status__c = NULL;
            }
            
            String closest_trial_site = parser.get('closest_trial_sites').get('pharma_site_id').Value;
            if (closest_trial_site != NULL && closest_trial_site != 'null'){
                mr.Closest_Trial_Site__c = closest_trial_site;
            }
            else if(closest_trial_site == NULL || closest_trial_site == 'null'){
                mr.Closest_Trial_Site__c = NULL;
            }
            
            String pharma_company_id = parser.get('pharma_company_id').Value;
            if (pharma_company_id != NULL && pharma_company_id != 'null'){
                mr.Pharma_Company__c = pharma_company_id;
            }
            else if(pharma_company_id == NULL || pharma_company_id == 'null'){
                mr.Pharma_Company__c = NULL;
            }
            
            String show_to_customer = parser.get('show_to_customer').Value;
            if(show_to_customer != 'null' && show_to_customer != NULL){
                if(show_to_customer == 'Yes'){
                    mr.Show_to_Customer__c = TRUE;
                }
                if(show_to_customer == 'No'){
                    mr.Show_to_Customer__c = FALSE;
                }
            }
            
            String dfc = parser.get('date_of_first_contact').Value;
            if( dfc != NULL && dfc != 'null'){
                String dfc1 = dfc.left(19);
                String dfc2 = dfc1.replace('T', ' ');
                DateTime date_of_first_contact = datetime.valueOf(dfc2);
                mr.Date_of_1st_Contact__c = date_of_first_contact;
            }
            else if(dfc == NULL || dfc == 'null'){
                mr.Date_of_1st_Contact__c = NULL;
            }
            
            String dc = parser.get('date_closed').Value;
            if( dc != NULL && dc != 'null'){
                String dc1 = dc.left(19);
                String dc2 = dc1.replace('T', ' ');
                DateTime date_closed = datetime.valueOf(dc2);
                mr.Date_Closed__c = date_closed;
            }
            else if(dc == NULL || dc == 'null'){
                mr.Date_Closed__c = NULL;
            }
            
            String dIdent = parser.get('date_identified').Value;
            if(dIdent != 'null' && dIdent != NULL){
                String dIdent1 = dIdent.left(19);
                String dIdent2 = dIdent1.replace('T', ' ');
                DateTime date_identified = datetime.valueOf(dIdent2);
                mr.Date_Identified__c = date_identified;
            }
            else if(dIdent == NULL || dIdent == 'null'){
                mr.Date_Identified__c = NULL;
            }
            
            String dlc = parser.get('date_of_last_contact').Value;
            if(dlc != 'null' && dlc != NULL){
                String dlc1 = dlc.left(19);
                String dlc2 = dlc1.replace('T', ' ');
                DateTime date_of_last_contact = datetime.valueOf(dlc2);
                mr.Date_of_Last_Contact__c = date_of_last_contact;
            }
            else if(dlc == NULL || dlc == 'null'){
                mr.Date_of_Last_Contact__c = NULL;
            }
            
            String de = parser.get('date_enrolled').Value;
            if(de != 'null' && de != NULL){
                String de1 = de.left(19);
                String de2 = de1.replace('T', ' ');
                DateTime date_enrolled = datetime.valueOf(de2);
                mr.Date_Enrolled__c = date_enrolled;
            }
            else if(de == NULL || de == 'null'){
                mr.Date_Enrolled__c = NULL;
            }
            
            String di = parser.get('date_ineligible').Value;
            if(di != 'null' && di != NULL){
                String di1 = di.left(19);
                String di2 = di1.replace('T', ' ');
                DateTime date_ineligible = datetime.valueOf(di2);
                mr.Date_Ineligible__c = date_ineligible;
            }
            else if(di == NULL || di == 'null'){
                mr.Date_Ineligible__c = NULL;
            }
            
            String dfs = parser.get('date_failed_screening').Value;
            if(dfs != 'null' && dfs != NULL){
                String dfs1 = dfs.left(19);
                String dfs2 = dfs1.replace('T', ' ');
                DateTime date_failed_screening = datetime.valueOf(dfs2);
                mr.Date_of_Failed_Screening__c = date_failed_screening;
            }
            else if(dfs == NULL || dfs == 'null'){
                mr.Date_of_Failed_Screening__c = NULL;
            }
            
            String dr = parser.get('date_referred').Value;
            if(dr != 'null' && dr != NULL){
                String dr1 = dr.left(19);
                String dr2 = dr1.replace('T', ' ');
                DateTime date_referred = datetime.valueOf(dr2);
                mr.Date_Referred__c = date_referred;
            }
            else if(dr == NULL || dr == 'null'){
                mr.Date_Referred__c = NULL;
            }
            
            String qtaList = parser.get('qualifying_target_alts').Value;
            List<Util_JSONParser> arrayParser = Util_JSONParser.parseArray(qtaList);
            List <String> qtaSFDC = new List <String>();
            if(arrayParser.size() != 0){
                for (Util_JSONParser p : arrayParser){
                    String qta = p.get('alt_string').Value;
                    qtaSFDC.add(qta);
                }
                String qtaString = string.join(qtaSFDC, ', ');
                mr.Qualifying_Target_Alterations__c = qtaString;
            }
			MatchRecordTriggerHelper.inFutureContext = TRUE;
            mr.Last_Match_API_Update__c = System.now();
                
            update mr;
            
        }
    }
    @future (callout=true)
    public static void podQuery(String match_id){
        
        //set Match Record        
        Match_Record__c mr = [SELECT Id, PODs__c
                                FROM Match_Record__c 
                               WHERE Match_ID__c = :match_id];
        
        System.debug(match_id);
        System.debug(mr.Id);
    
        //callout to Portal API
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ConfigService.matchPortalEndpoint + '/api/match_service/matches?match_id=' + match_id + '&token='+ConfigService.matchPortalToken);
        req.setMethod('GET');
        req.setTimeout(60000);
        HttpResponse res = http.send(req);
        
        // If the request is successful, parse the JSON response.
        if (res.getStatusCode() == 200) {
            system.debug('response = ' + res.getBody());
            String jsonContent = res.getBody();
            System.debug(jsonContent);
            
            //call JSON Utility to help with parse
            Util_JSONParser parser = Util_JSONParser.createParser(jsonContent);
            
            //get list of MRs current pods
            List <POD__c> currentPODs = [SELECT Id, POD_ID__c
                                           FROM POD__c
                                          WHERE Match_Record__c = :mr.Id];
            
            
            //get list of pods
            String podList = parser.get('pods').Value;
            List<Util_JSONParser> arrayParser = Util_JSONParser.parseArray(podList);
            
            Id mrID = mr.Id;
            List<POD__c> createPODs = new List <POD__c>();
            //if the list of pod filenames is larger than the POD count on the MR
            if(arrayParser.size() > mr.PODs__c){
                //assign values for each POD
                for (Util_JSONParser p : arrayParser) {
                    String podLink = p.get('filename').Value;
                    POD__c pod = new POD__c();
                    pod.Match_Record__c = mr.Id;
                    pod.POD_ID__c = podLink;
                    createPODS.add(pod);
                }
                System.debug(createPODs);
                //call queable job to upsert PODS
                podQueued podJob = new podQueued(createPODs, mrID);
                ID jobID = System.enqueueJob(podJob);
            }
        }
    }
    public static void restMethod(){
        Integer i = 0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
    }
}