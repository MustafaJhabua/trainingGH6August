public class caseHandler{
public static void OnAfterInsert(case[] newRecords){
        
            caseActions.createplatformevent(newRecords,'new');
        
    }
    
     public static void OnAfterDelete(case[] deletedRecords, Map<ID, case> recordMap){
        caseActions.createPlatformEvent(deletedRecords,'Delete');

    }
    
    
        public static void OnAfterUpdate(case[] oldRecords, case[] updatedRecords, Map<ID, case> oldMap, Map<ID, case> newMap){
                caseActions.createplatformevent(updatedRecords,'Update');
       }

}