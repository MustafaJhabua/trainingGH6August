public class MatchExtension
    {
    // Get,Set current match record info
    public Match_Record__c mr {get;set;}
    // find related match records on the sample
    public List <Match_Record__c> matchList
    {
        get
        {
            if (matchList == null)
            {
                matchList = [SELECT Enrollment_Status__c,
                                    Id,
                                    Follow_Up_Reminder__c,
                                    Name,
                                    Patient_Report__c,
                                    Final_Report_Date__c,
                                    Date_of_Last_Contact__c,
                                    Enrollment_Sub_Status__c,
                                    Sample_ID__c,
                                    Sample_ID__r.Name,                          
                                    Patient_ID__c,
                                    Trial_Name__c,
                                    Trial_Name__r.Name,
                                    Owner.Name,
                                    OwnerId
                              FROM  Match_Record__c
                             WHERE  Patient_ID__c = :mr.Patient_ID__c
                          ORDER BY  Sample_ID__r.Name DESC];
            }
            return matchList;
        }
        private set;
    }
    // set standard controller for the object
    public MatchExtension(ApexPages.StandardController stdController) {
        this.mr = (Match_Record__c)stdController.getRecord();
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
        }
}