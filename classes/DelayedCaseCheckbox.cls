public class DelayedCaseCheckbox
{
@future
public static void updatingSample(string sampleId)
{
List<case> gs=[select id from case where Guardant_360_Sample__c=:sampleId and Guardant_360_Sample__r.Delayed_Sample_Case_Created__c= false];
if(gs.size() > 0){
     Guardant_360_Sample__c  gSample= new Guardant_360_Sample__c(id=sampleId,Delayed_Sample_Case_Created__c=true);
     update gSample;
}
}
}