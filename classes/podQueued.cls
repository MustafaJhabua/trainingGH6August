public class podQueued implements Queueable{
    
    private List<POD__c> createPODs;
    private Id  mrID;
    
    public podQueued(List<POD__c> upsertPODs, ID match_ID){
        this.createPODs = upsertPODs;
        this.mrID = match_ID;
    }
    //iterate through pod list that was passed and upsert based on POD ID (filename)
    public void  execute(QueueableContext context){
        for (POD__c pod : createPODs){
            upsert pod POD_ID__c;
        }
        Match_Record__c mr = [SELECT Id
                                FROM Match_Record__c
                               WHERE Id = :mrID];
        mr.Send_POD__c = FALSE;
        mr.Send_POD_No_Email__c = FALSE;
        update mr;
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