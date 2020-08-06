public class PushOrderToTheraPak {

    private static boolean run = true;
    public static boolean runOnce(){
        if(run){
            run=false;
            return true;
        }else{
            return run;
        }
    }
    
    public static void start(List<Case> TriggerNew) {
        Map<String, Object> myMap = new Map<String, Object>();
        
        for(Case cs: TriggerNew) {
            if(cs.Push_To_TheraPak__c == true) {
                myMap.put('txtCaseRecordID', String.valueOf(cs.Id));
                Flow.Interview.Create_Supplies_Order myFlow = new Flow.Interview.Create_Supplies_Order(myMap);
                myFlow.start();
            }
        }
    }
}