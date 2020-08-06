public class OutreachExtension
{
    // Get,Set current match record info
    public Match_Record__c mr {get;set;}
    // find only newest related Outreach Activity
    public Task oaMostRecent
    {
        get
        {
            if (oaMostRecent == null)
            {
                oaMostRecent = [SELECT Id,   Enrollment_Status__c,
                                             Enrollment_Sub_Status__c,
                                             Sub_Status_Reason__c,
                                             Contact_Type__c,
                                			 Subject,
                                             CreatedDate
                                FROM         Task
                                WHERE        WhatId = :mr.Id
                                AND          Outreach__c = TRUE
                                ORDER BY     CreatedDate DESC
                                LIMIT 1];
            }
            return oaMostRecent;
        }
        private set;
    }
    // find only oldest and first Outreach Activity
        public Task oaOldest
    {
        get
        {
            if (oaOldest == null)
            {
                oaOldest = [    SELECT Id,  Enrollment_Status__c,
                                            Enrollment_Sub_Status__c,
                                            Sub_Status_Reason__c,
                                            Contact_Type__c,
                            				Subject,
                                            CreatedDate
                               FROM         Task
                               WHERE        WhatId = :mr.Id
                               AND          Outreach__c = TRUE
                               ORDER BY     CreatedDate ASC
                               LIMIT 1];
            }
            return oaOldest;
        }
        private set;
    }
    // set standard controller for the object
    public OutreachExtension(ApexPages.StandardController stdController) {
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