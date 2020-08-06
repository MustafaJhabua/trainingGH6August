/*************************************************
   Class Name : sendChangesToPortal
   Author     : Siva
  Description : This class will send the referral sub status changes to portal.
                It is written for providing a quick fox for ticket 7616
                
**************************************************/
public class sendChangesToPortal{
    @invocableMethod(Label='Sending Referral Sub Status')
    public static void sendValuesToPortal(List<Match_Record__c> matchList){
    List<String> matchRecordTokens = new List<String>();
    String basePortalAPI = ConfigService.matchPortalEndpoint + 'api/match_service/matches?match_id=';
    String authToken = '&token=' + ConfigService.matchPortalToken;
    List <String> API = new List <String>();
    //Added the below condition for ENt-7616 for the third scenario  “Emailed” MRs
    API.add('enrollment_status_sub_status=Emailed');
    
    basePortalAPI = basePortalAPI + matchList[0].Match_ID__c+ authToken + '&';

    String apiString = String.join(API, '&');
    String postAPI = basePortalAPI + apiString;
    System.debug('basePortalAPI = ' + basePortalAPI);

    System.debug('postAPI = ' + postAPI);
    matchRecordTokens.add(postAPI);
    if(!test.isrunningtest()){
    MatchRecordTriggerHandler.sendMatchRecordTokens(matchRecordTokens);
    }
    }
}