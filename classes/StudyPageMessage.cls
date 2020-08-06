public with sharing class StudyPageMessage {

    public Patient patient;
    public Trial_site trial_site;
    public List<Trial_site_pis> trial_site_pis;
    public List<Trial_site_contacts> trial_site_contacts;
    public Ordering_physician ordering_physician;
    public Trial trial;

    public class Patient {
        public String match_key;
        public String patient_initials;
        public String qualifying_target_alteration;
        public Date final_report_date;
        public String cancer_type;
        public String portal_url;
    }

    public class Trial_site {
        public String name;
        public Address address;
    }

    public class Trial_site_pis {
        public String first_name;
        public String last_name;
        public String npi;
    }

    public class Trial {
        public String name;
        public String nct_id;
        public String study_code;
    }

    public class Address {
        public String street;
        public String city;
        public String state;
        public String zip;
    }

    public class Trial_site_contacts {
        public String first_name;
        public String last_name;
        public String email;
        public String phone;
        //public String role;
    }

    public class Pharma_contacts {
        public String first_name;
        public String last_name;
        public String email;
        public String phone;
        public String role;
    }

    public class Ordering_physician {
        public String first_name;
        public String last_name;
        public String phone;
        public String email;
        public String practice_name;
        public Address address;
    }

    public class Data{
        public String scheduling_url;
    }

    public class Response{
        public String status;
        public Data data;
        public List<String> errors;
    }

    public static StudyPageMessage parse(String json) {
        return (StudyPageMessage) System.JSON.deserialize(json, StudyPageMessage.class);
    }

    public HttpResponse sendMessage(StudyPageMessage message){
        //callout to Yuzu API
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(System.Label.Yuzu_Endpoint);
        req.setMethod('POST');
        req.setHeader('Authorization','Bearer '+System.Label.Yuzu_Token);
        req.setHeader('Content-Type','application/json');
        req.setBody(System.JSON.serialize(message));
        System.debug('==message: ' + System.JSON.serializePretty(message));
        HttpResponse resp = http.send(req);
        return resp;
    }

}


/*
===========================
Admin dashboard
===========================
https://proto.studypages.com/gh_admin_checker/

===========================
API request details
===========================
Endpoint: https://proto.studypages.com/siteconnect_api_test/guardant/v0.1/new_call_request/
Method: POST
Content-Type: application/json
Authorization: Bearer stdeINNvfamwNxRV2woTzQTEmKCF43c2

===========================
Example
===========================

----------------
Request
----------------
{
    "patient": {
        "match_key": "TRL123-0001",
        "patient_initials": "DV",
        "qualifying_target_alteration": "[QTA Placeholder]",
        "final_report_date": "2018-05-30",
        "cancer_type": "[CancerType Placeholder]",
        "portal_link": "[Portal Link Placeholder]"
    },
    "trial_site": {
        "name": "UCLA Jonsson Comprehensive Cancer Center",
        "address": {
            "street": "10833 Le Conte Ave",
            "city": "Los Angeles",
            "state": "CA",
            "zip": "90024"
        }
    },
    "trial_site_pis": [
        {
            "first_name": "Laura",
            "last_name": "Turtzo",
            "npi": "1245319599"
        }
    ],
    "trial_site_contacts": [
        {
            "first_name": "John",
            "last_name": "Smith",
            "email": "eron+j.smith@yuzulabs.com",
            "phone": "(555) 151-5511",
            "role": "Investigator"
        }
    ],
    "pharma_contacts": [
        {
            "first_name": "PharmaFN",
            "last_name": "PharmaLN",
            "email": "eron+p.contact@yuzulabs.com",
            "phone": "(555) 515-5511",
            "role": "Investigator"
        }
    ],
    "ordering_physician": {
        "first_name": "Lucy",
        "last_name": "Algerin",
        "phone": "1234567890",
        "email": "eron+ordering.physician@yuzulabs.com",
        "practice_name": "Community Hospital",
        "address": {
            "street": "342 Main Street",
            "city": "Redwood City",
            "state": "CA",
            "zip": "94131"
        }
    },
    "trial": {
        "name": "Trial TRL123",
        "study_id": "TRL123",
        "intervention": "TrialDrugName",
        "nct_id": "NCT02881125"
    }
}

----------------
Response-Success
----------------
{
    "status": "success",
    "data": {
        "scheduling_url": "https://proto.studypages.com/gh_availability/111_random_id_goes_here_111/"
    }
}

----------------
Response-Error
----------------
{
    "status": "error",
    "errors": [
        "Only POST requests are accepted"
    ]
}

{
    "status": "error",
    "errors": [
        "'patient' is a required property",
        "'ordering_physician' is a required property",
        "'trial' is a required property",
        "'trial_site_pis' is a required property",
        "'trial_site_contacts' is a required property"
    ]
}

===========================
Changelog
===========================
Updates:
- Accept null values for all optional fields
- Added 2 optional fields to "patient": "cancer_type" and "portal_link"
- Changed "trial.intervention" from required to optional
- Added optional field "trial.nct_id"
- Separate "pharma_contacts.name" into "first_name" and "last_name"
- remove "email" and "phone" from "trial_site_pis" and require at least one of "trial_site_contacts" with "email"


TODOs:
- TBD
 */