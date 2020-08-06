public class caseActions{
public static void createPlatformEvent(List<case> caseRecords, String dmlType){
       
        List<ModifiedRecord__e> publishEvents = new List<ModifiedRecord__e>();
        for(case a : caseRecords){
            ModifiedRecord__e    eve = new ModifiedRecord__e();
            eve.ObjectName__c = 'case' ; 
            eve.recordid__C= a.id ; 
            if(dmlType == 'Delete'){
            eve.IsDeleted__c =true;
            }
            else{
             eve.IsDeleted__c =false;

            }
            
            publishEvents.add(eve);            
        }
        if(publishEvents.size()>0){
            EventBus.publish(publishEvents);
        }
    }
}