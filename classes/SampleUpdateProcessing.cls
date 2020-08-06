public class SampleUpdateProcessing {
 
    public static void setRollups(List<Guardant_360_Sample__c> TriggerNew) {
        //Set<Id> setAccountId = new Set<Id>();
        Set<Id> contactIdSet = new Set<Id>();

        for(Guardant_360_Sample__c trf: TriggerNew) {
            //setAccountId.add(trf.Account__c);
            contactIdSet.add(trf.Contact__c);
        }

        //Set Latest Sample on Contact Last_Sample__c

        //Query all the contacts and latest samples
        List<Contact> contactList = [SELECT id, (
                                                SELECT id , Date_Received__c 
                                                FROM Guardant_360_Samples__r 
                                                ORDER BY Date_Received__c DESC
                                                LIMIT 1)
                                    FROM Contact
                                    WHERE Id in:contactIdSet];

        for(Contact c : contactList){
            c.Last_Sample__c = c.Guardant_360_Samples__r[0].id;
        }
        update contactList;


        // Set rollup values on Account

        //Account objAcc;
        //AggregateResult[] agrSample = [SELECT Account__c, MIN(Date_Received__c), MAX(Date_Received__c), COUNT(Id) 
        //                                FROM Guardant_360_Sample__c WHERE Account__c IN :setAccountId GROUP BY Account__c];
        
        //List<Account> updAcc = new List<Account>();
       
        //for(AggregateResult ar: agrSample) {
        //    objAcc = new Account(Id = (id)ar.get('Account__c'),
        //                         First_Sample_Date__c = date.valueOf(ar.get('expr0')),
        //                         Last_Sample_Date__c = date.valueOf(ar.get('expr1')),
        //                         Number_of_Samples__c = integer.valueOf(ar.get('expr2')));
        //    updAcc.add(objAcc);

        //}

        //update updAcc;
    }


    public static void setPrevious(List<Guardant_360_Sample__c> TriggerNew) {
        Set<Id> setContactId = new Set<Id>();     

        for(Guardant_360_Sample__c trf: TriggerNew) {
            setContactId.add(trf.Contact__c);
        }

        // Set previous sample date 

        List<Guardant_360_Sample__c> lstTRF = [select Id, Contact__c, Date_Received__c from Guardant_360_Sample__c
                                               where Contact__c IN :setContactId order by Date_Received__c ASC];
        
        Date prevDate = null;
        boolean prevDateIsSet = false;
        Guardant_360_Sample__c objTRF = null;

        List<Guardant_360_Sample__c> updTRF = new List<Guardant_360_Sample__c>();

        for(Guardant_360_Sample__c trf: TriggerNew) {
        
            //find previous sample date
            for(Guardant_360_Sample__c prevtrf: lstTRF) {
                if(prevtrf.Contact__c == trf.Contact__c && prevtrf.Date_Received__c < trf.Date_Received__c) {
                    trf.Previous_Date_Received_Contact__c = prevtrf.Date_Received__c;
                 }
            }
        }
    }
}