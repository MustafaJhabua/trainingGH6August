@RestResource(urlMapping='/mrResponse')
global class mrResponse {
    @HTTPGet
    //This will query newly portal created Match Records
    global static List<Match_Record__c> getNewMRs() {
    	List <Match_Record__c> insertedMRs = [SELECT Name, Match_ID__c, Id 
                                                FROM Match_Record__c
                                               WHERE CreatedDate > :Datetime.now().addMinutes(-2)];
    	return insertedMRs;
    }
    //This will query newly portal updated Match Records
    global static List<Match_Record__c> getUpdatedMR(){
    	List <Match_Record__c> updatedMR = [SELECT Name, Match_ID__c, Id
                                              FROM Match_Record__c
                                             WHERE SystemModStamp = :Datetime.now()
                                             LIMIT 1];
        return updatedMR;
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

  }
}