/**********************************************
  Author : Siva
  Description : This class will be called from the Match record list view button through a webservice class
  It will call the sfdc_sync_checker job in portal

*************************************************/
global class runSyncPortal{ 
   
    @future(callout=true)
     global static void runSyncChecker(){   
    
                //callout to Portal API
                Http http = new Http();
                HttpRequest req = new HttpRequest();
                // configservice class will return the token and endpoint details from metadata 
                req.setEndpoint(ConfigService.matchPortalEndpoint + '/jobs/sfdc_sync_checker?token='+ConfigService.matchPortalToken);
                req.setMethod('POST');
                req.setTimeout(60000);
                HttpResponse res = new HttpResponse();
                if(!Test.isrunningTest()){
                res = http.send(req);
                }
                system.debug(res.getBody());
                // If the request is successful, parse the JSON response.
                if (res.getStatusCode() == 200) {
                    System.debug('response = ' + res.getBody());
                    String jsonContent = res.getBody();
                    System.debug(jsonContent);
    
                   
                }
    }
   
}