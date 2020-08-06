public with sharing class Lims {
    public Lims() {
        
    }

    /*******************************************************************************************************
    * @description Apex model of the LIMS JSON SQS Message.
    */
    public class Practice{
        public String Object_id;
        public String Status;
        public Lims.PracticeData Details = new Lims.PracticeData();
    }

    public class PracticeData{
        public String account_id;
        public String account_number;
        public String name;
        public String address_line1;
        public String address_line2;
        public String city;
        public String state;
        public String country;
        public String zip;
        public String fax;
        public String phone;
        public String is_qualified;
        public String trialSiteNumber;

    }

    public class Affiliation{
        public String Object_id;
        public String Status;
        public Lims.AffiliationData Details = new Lims.AffiliationData();
    }

    public class AffiliationData{
        public String affiliation_id;
        public String contact_id;
        public String account_id;
        public String user_name;
        public String report_delivery_method;
        public String needs_treatment;
        public String is_newyork_physician;
        public String billing_indicator;
        public String fax;
        public String other_npino;
        public String is_qualified;
        public String push_to_labvantage;
        public String report_additional_information;
        public String AccountLinked;
    }

    public class Physician{
        public String Object_id;
        public String Status;
        public Lims.PhysicianData Details = new Lims.PhysicianData();
    }

    public class PhysicianData{
        public String first_name;
        public String last_name;
        public String fax;
        public String contact_id;
        public String account_id;
        public String npi_no;
        public String needs_treatment;
        public String billing_indicator;
        public String is_newyork_physician;
        public String is_qualified;
        public String email_address;
        public String report_delivery_method;
        public String is_secondary_physician;
        public String push_to_labvantage;
        public String user_name;
        public String is_unqualified_by_cs;
        public String report_additional_information;
        public String AccountLinked;
        public String threshold_date;
    }

    public static list<Schema.FieldSetMember> LookupTrackedFields(string[] objectName, String fieldsetName){        
        List<Schema.FieldSetMember> trackedFields = new List<Schema.FieldSetMember>();
        Schema.DescribeSobjectResult[] results = Schema.describeSObjects(objectName);
        for(Schema.DescribeSobjectResult res : results) {
            trackedFields = res.fieldsets.getMap().get(fieldsetName).getFields();
        }
        if (trackedFields.isEmpty()) return null;
        return trackedFields;
    }

    @future(callOut=true)
    public static void sendToLIMS(String payload){


        system.debug('payload***'+payload);
        AWS_Credentials__c awsConfigSettings = AWS_Credentials__c.getInstance();
        String limsAccess = awsConfigSettings.Physician_Update_Access_Key__c;
        String limsSecret = awsConfigSettings.Physician_Update_Secret_Key__c;
        String limsBaseUrl = awsConfigSettings.Physician_Update_SQS_Base_URL__c;
        String limsQueuePath = awsConfigSettings.Physician_Update_SQS_Queue__c;

        SQS s = new SQS(limsAccess, limsSecret);
        s.baseUrl = limsBaseUrl;
        s.queuePath = limsQueuePath; 
        s.method = 'GET';
        s.parameters.put('Action', 'SendMessage');
        s.parameters.put('MessageBody', SQS.encode(payload));
        if(!Test.isRunningTest())s.sendMessage();

    }
    
}