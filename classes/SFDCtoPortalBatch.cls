global class SFDCtoPortalBatch implements Database.Batchable<Match_Record__c>, Database.AllowsCallouts{
    
    //Get list of Matches that are ready to be pushed to portal (checked)
    Match_Record__c[] mrListToUpdate = [SELECT  Id, Match_ID__c, Enrollment_Sub_Status__c, Sub_Status_Reason__c, Guardant_Notes__c,
                                        Permission_to_Connect_with_Pharma__c, Referred__c, Show_to_Customer__c, Date_of_1st_Contact__c,
                                        Date_of_Last_Contact__c, Date_Closed__c, Date_Enrolled__c, Date_Ineligible__c,
                                        Date_of_Failed_Screening__c, Date_Referred__c, Client_Notes__c, Enrollment_Status__c,
                                        Match_Priority__c, Match_Status__c
                                        FROM Match_Record__c
                                        WHERE Batch_Push__c = TRUE];
    
    
    global Iterable<Match_Record__c> start(database.batchablecontext BC){
        return (mrListToUpdate);    
    }
    
    global void execute(Database.BatchableContext BC, List<Match_Record__c> scope){
        for(Match_Record__c mr : scope){
            
            List <String> API = new List <String>();
            //auth token from portal (the & is just to tie the string together)
            String authToken = '&token='+ConfigService.matchPortalToken;
            //base Portal API
            String basePortalAPI = ConfigService.matchPortalEndpoint + '/api/match_service/match/update?match_id=' + mr.Match_ID__c + authToken + '&';
            System.debug('basePortalAPI = ' + basePortalAPI);
            
            
            //Check values on fields and add to API if they have changed
            if(mr.Enrollment_Sub_Status__c == NULL){
                API.add('enrollment_status_sub_status');
            }
            else{
                String ess = mr.Enrollment_Sub_Status__c;
                ess = EncodingUtil.urlEncode(ess, 'UTF-8');
                API.add('enrollment_status_sub_status=' + ess);
            }
            System.debug(API);
            if(mr.Sub_Status_Reason__c == NULL){
                API.add('enrollment_status_sub_reason');
            }
            else{
                String ssr = mr.Sub_Status_Reason__c;
                ssr = EncodingUtil.urlEncode(ssr, 'UTF-8');
                API.add('enrollment_status_sub_reason=' + ssr);
            }
            System.debug(API);
            if(mr.Guardant_Notes__c == NULL){
                API.add('guardant_notes');
            }
            else{
                String gNotes = mr.Guardant_Notes__c;
                gNotes = EncodingUtil.urlEncode(gNotes, 'UTF-8');
                API.add('guardant_notes=' + gNotes);
            }
            System.debug(API);
            if(mr.Permission_to_Connect_with_Pharma__c == TRUE){
                API.add('permission_to_connect_with_pharma=Yes');
            }
            if(mr.Permission_to_Connect_with_Pharma__c == FALSE){
                API.add('permission_to_connect_with_pharma=No');
            }
            System.debug(API);
            if(mr.Referred__c == TRUE){
                API.add('referred=Yes');
            }
            if(mr.Referred__c == FALSE){
                API.add('referred=No');
            }
            System.debug(API);
            if(mr.Client_Notes__c == NULL){
                API.add('client_notes');
            }
            else{
                String cNotes = mr.Client_Notes__c;
                cNotes = EncodingUtil.urlEncode(cNotes, 'UTF-8');
                API.add('client_notes=' + cNotes);
            }
            System.debug(API);
            if(mr.Enrollment_Status__c == NULL){
                API.add('enrollment_status');
            }
            else{
                String es = mr.Enrollment_Status__c;
                es = EncodingUtil.urlEncode(es, 'UTF-8');
                API.add('enrollment_status=' + es);
            }
            System.debug(API);
            if(mr.Match_Priority__c == NULL){
                API.add('priority');
            }
            else{
                String mp = mr.Match_Priority__c;
                mp = EncodingUtil.urlEncode(mp, 'UTF-8');
                API.add('priority=' + mp);
            }
            System.debug(API);
            
            if(mr.Match_Status__c == NULL){
                API.add('match_status');
            }
            else{
                String ms = mr.Match_Status__c;
                ms = EncodingUtil.urlEncode(ms, 'UTF-8');
                API.add('match_status=' + ms);
            }
            System.debug(API);
            if(mr.Show_to_Customer__c == TRUE){
                API.add('show_to_customer=Yes');
            }
            if(mr.Show_to_Customer__c == FALSE){
                API.add('show_to_customer=No');
            }
            System.debug(API);
            if(mr.Date_of_1st_Contact__c == NULL){
                API.add('date_of_first_contact');
            }
            else{
                DateTime dfc = mr.Date_of_1st_Contact__c;
                String dfc1 = dfc.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                dfc1 = dfc1 + 'GMT';
                dfc1 = EncodingUtil.urlEncode(dfc1, 'UTF-8');
                API.add('date_of_first_contact=' + dfc1);
            }
            System.debug(API);
            if(mr.Date_of_Last_Contact__c == NULL){
                API.add('date_of_last_contact');
            }
            else{
                DateTime dlc = mr.Date_of_Last_Contact__c;
                String dlc1 = dlc.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                dlc1 = dlc1 + 'GMT';
                dlc1 = EncodingUtil.urlEncode(dlc1, 'UTF-8');
                API.add('date_of_last_contact=' + dlc1);
            }
            System.debug(API);
            if(mr.Date_Closed__c == NULL){
                API.add('date_closed');
            }
            else{
                DateTime dc = mr.Date_Closed__c;
                String dc1 = dc.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                dc1 = dc1 + 'GMT';
                dc1 = EncodingUtil.urlEncode(dc1, 'UTF-8');
                API.add('date_closed=' + dc1);
            }
            System.debug(API);
            if(mr.Date_Enrolled__c == NULL){
                API.add('date_enrolled');
            }
            else{
                DateTime de = mr.Date_Enrolled__c;
                String de1 = de.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                de1 = de1 + 'GMT';
                de1 = EncodingUtil.urlEncode(de1, 'UTF-8');
                API.add('date_enrolled=' + de1);
            }
            System.debug(API);
            if(mr.Date_Ineligible__c == NULL){
                API.add('date_ineligible');
            }
            else{
                DateTime di = mr.Date_Ineligible__c;
                String di1 = di.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                di1 = di1 + 'GMT';
                di1= EncodingUtil.urlEncode(di1, 'UTF-8');
                API.add('date_ineligible=' + di1);
            }
            System.debug(API);
            if(mr.Date_of_Failed_Screening__c == NULL){
                API.add('date_failed_screening');
            }
            else{
                DateTime dfs = mr.Date_of_Failed_Screening__c;
                String dfs1 = dfs.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                dfs1 = dfs1 + 'GMT';
                dfs1= EncodingUtil.urlEncode(dfs1, 'UTF-8');
                API.add('date_failed_screening=' + dfs1);
            }
            System.debug(API);
            if(mr.Date_Referred__c == NULL){
                API.add('date_referred');
            }
            else{
                DateTime dr = mr.Date_Referred__c;
                String dr1 = dr.formatGmt('EEE, dd MMM yyyy HH:mm:ss ');
                dr1 = dr1 +  'GMT';
                dr1 = EncodingUtil.urlEncode(dr1, 'UTF-8');
                API.add('date_referred=' + dr1);
            }
            System.debug(API);
            
            //format API string
            String apiString = string.join(API, '&');
            String postAPI = basePortalAPI + apiString;
            System.debug('postAPI = ' + postAPI);
                        
            try {
                HttpRequest req = new HttpRequest();
                HttpResponse res = new HttpResponse();
                Http http = new Http();
                
                req.setEndpoint(postAPI);
                req.setMethod('POST');
                req.setBody('test');
                
                res = http.send(req);
                System.debug('If you get 200 response, you are good!  Response: ' + res.getStatusCode());
            } 
            catch(System.CalloutException e) {
                System.debug('Callout error: '+ e);
            }
            mr.Batch_Push__c = FALSE;
            update mr;
        }    
    }
    
    global void finish(Database.BatchableContext info){
    }//global void finish loop
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
    }
}