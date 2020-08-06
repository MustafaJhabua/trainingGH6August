public class MatchCountFlow {
    public static void callFlow(List<Match_Record__c> mrList){
        Set<Id> contactIds = new Set<Id>();
        for(Match_Record__c mr : mrList){
            contactIds.add(mr.Ordering_Physician_Name__c);
        }
        List <Contact> contactsToUpdate = new List <Contact>([SELECT Id, Name
                                                        FROM Contact
                                                       WHERE Id = :contactIds]);
        for(Contact c : contactsToUpdate){
            c.Fire_Match_Count_Flow__c = TRUE;
        }
        update contactsToUpdate;
    }
}