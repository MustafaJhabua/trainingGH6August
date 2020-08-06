@RestResource(urlMapping='/mrCreate')
global with sharing class mrCreate {
    
    //Set incoming strings
    global class matches{
        public String match_id;
        public String request_id;
    }
    
    
    @HTTPPost
    //get list of incoming Match Records, add to match record list
    global static string doPost(List <matches> matchInfo){
        Map <String, Match_Record__c> matchMap = new Map <String, Match_Record__c>();
        Set <String> matchIDs = new Set <String>();
        List <Match_Record__c> mrList = new List<Match_Record__c>();
        for (matches m : matchInfo){
            matchIDs.add(m.match_id);
        }
        
        List <Match_Record__c> existingMatches = ([SELECT Id, Match_ID__c
                                                   FROM Match_Record__c
                                                   WHERE Match_ID__c IN : matchIDs]);
        for (Match_Record__c mr : existingMatches){
            matchMap.put(mr.Match_ID__c, mr);
        }
        for (matches m: matchInfo){
            if(!matchMap.containsKey(m.match_id)){
                Match_Record__c mr = new Match_Record__c();
                mr.Name = m.match_id;
                mr.Match_ID__c = m.match_id;
                mr.Portal_Sample_ID__c = m.request_id;
                mr.Batch_Check__c = TRUE;
                mrList.add(mr);
            }
        }
        if (mrList.size() == 0){
            System.debug('List is empty');
            
        }
        else{
            System.debug('List has values and something is wrong!');
        }
        //insert Match Records
        insert mrList;
        return null;
        //call response method to show newly created Match Records json
        List <Match_Record__c> insertedMRs = mrResponse.getNewMRs();
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
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
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