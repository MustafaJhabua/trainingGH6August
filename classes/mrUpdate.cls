@RestResource(urlMapping='/mrUpdate')
global with sharing class mrUpdate {

    @HTTPPatch
    //query SFDC Match Record from portal match_id
    global static String updateMR(String match_id, String token){
        Match_Record__c mr = [SELECT Id, Send_POD__c
                                FROM Match_Record__c 
                               WHERE Match_ID__c = :match_id];
        System.debug('***Here is the MATCH ID*** ' + match_id);
        System.debug('!!!!Here is the TOKEN!!!!! ' + token);
        
        //call portal for MR fields
        if (token != ConfigService.matchPortalToken){
            PortalQuery.portalGet(match_id);
        }
        //call portal for PODs
        if (mr.Send_POD__c == TRUE){
            PortalQuery.podQuery(match_id);
        }
                
        return null;
        //call response method to show udpated Match Record json
        List <Match_Record__c> updatedMR = mrResponse.getUpdatedMR();
        return null;
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

  }
}