public with sharing class MatchRecordResponse {
    public String client_notes;
    public MatchRecordResponse.ClosestTrialSites closest_trial_sites = new MatchRecordResponse.ClosestTrialSites();
    public String competing_trials;
    public Datetime date_closed;
    public Datetime date_enrolled;
    public Datetime date_failed_screening;
    public Datetime date_identified;
    public Datetime date_ineligible;
    public Datetime date_of_first_contact;
    public Datetime date_of_last_contact;
    public Datetime date_referred;
    public String enrollment_status;
    public String enrollment_status_sub_reason;
    public String enrollment_status_sub_status;
    public String guardant_notes;
    public Decimal match_algorithm_version;
    public String match_key;
    public String match_status;
    public String permission_to_connect_with_pharma;
    public String pharma_company_id;
    public String priority;
    public String ordering_practice_site_type;
    public List<MatchRecordResponse.QualifyingTargetAlt> qualifying_target_alts = new List<MatchRecordResponse.QualifyingTargetAlt>();
    public String referred;
    public String show_to_customer;
    public String trial_id;
    
    public class ClosestTrialSites {
        public String pharma_site_id;
    }

    public class QualifyingTargetAlt {
        public String alt_string;
        public String gene_name;
        public String alt_type;
    }

    public static MatchRecordResponse parse(String json){
        return (MatchRecordResponse) System.JSON.deserialize(json, MatchRecordResponse.class);
    }

}