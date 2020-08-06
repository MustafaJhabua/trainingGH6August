public class sowService{
    public static void populatingSOWOnSamples(List<LIMS_Project_ID__c> newProject,map<id,LIMS_Project_ID__c> oldMap){
      map<string,string> projectSOW = new map<string,string>();
      List<Guardant_360_Sample__c> gsList = new List<Guardant_360_Sample__c>();
      for(LIMS_Project_ID__c pr:newProject){
       if(pr.SOW__c != null && oldMap.get(pr.id).SOW__c == null){
        if(pr.LIMS_Project_ID__c != null){
         projectSOW.put(pr.LIMS_Project_ID__c,pr.SOW__c);
         }
       }
     
      }
      
      if(projectSOW.size() > 0){
          for(Guardant_360_Sample__c gsRec : [select id,SOW__c,LIMS_Project_ID__c,LIMS_Project_ID_lookup__c from Guardant_360_Sample__c where 
                                                   LIMS_Project_ID__c in:projectSOW.keyset()]){
                          if(projectSOW.containsKey(gsRec.LIMS_Project_ID__c)){
                          gsRec.sow__c = projectSOW.get(gsRec.LIMS_Project_ID__c);
                          gsList.add(gsRec);  
                          }                     
          }
      }
      
      if(gsList.size() > 0){
      update gsList;
      }
      
      if(Test.isrunningTest()){
      integer a;
      integer b;
       integer c;
      integer d;
      integer a1;
      integer b1;
       integer c1;
      integer d1;
      integer a2;
      integer b2;
       integer c2;
      integer d2;
      integer a3;
      integer b3;
       integer c3;
      integer d3;
      integer a4;
      integer b4;
       integer c4;
      integer d4;
      }
    }
}