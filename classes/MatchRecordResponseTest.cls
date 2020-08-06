@IsTest(SeeAllData = false)
public with sharing class MatchRecordResponseTest {


    private static String jsonResponse =
            '   {'+
            '       \"algorithm_request_id\":\"mirati_mir516_1_A79194\",'+
            '       \"client_notes\":null,'+
            '       \"closest_trial_sites\":{'+
            '           \"id\":3,'+
            '           \"match_id\":\"M00010\",'+
            '           \"created_at\":\"2018-04-18T17:11:59.000-07:00\",'+
            '           \"updated_at\":\"2018-04-27T10:37:05.988-07:00\",'+
            '           \"name\":\"Kansas City Research Institute\",'+
            '           \"address\":\"  Kansas City, MO 64131 \",'+
            '           \"site_type\":\"CRO\"'+
            '       },'+
            '       \"created_at\":\"2018-04-26T23:16:59.000-07:00\",'+
            '       \"competing_trials\":\"Yes\",'+
            '       \"date_closed\":null,'+
            '       \"date_enrolled\":null,'+
            '       \"date_failed_screening\":null,'+
            '       \"date_identified\":\"2018-04-26T23:16:59.000-07:00\",'+
            '       \"date_ineligible\":null,'+
            '       \"date_of_first_contact\":null,'+
            '       \"date_of_last_contact\":null,'+
            '       \"date_referred\":null,'+
            '       \"date_rejected\":null,'+
            '       \"enrollment_status\":\"New\",'+
            '       \"enrollment_status_sub_reason\":\"\",'+
            '       \"enrollment_status_sub_status\":\"\",'+
            '       \"follow_up_date\":null,'+
            '       \"guardant_notes\":null,'+
            '       \"match_algorithm_id\":6,'+
            '       \"match_algorithm_version\":1,'+
            '       \"match_id\":\"M00010\",'+
            '       \"match_key\":\"MIR516-0006\",'+
            '       \"match_status\":\"Accepted\",'+
            '       \"patient_id\":100021727,'+
            '       \"permission_to_connect_with_pharma\":\"No\",'+
            '       \"pharma_company_id\":\"0013400001Qgu5pAAB\",'+
            '       \"pharma_company_name\":\"Mirati Therapeutics (Portal)\",'+
            '       \"pharma_trials_id\":\"a1D3400000DtI8jEAF\",'+
            '       \"pod_filename\":null,'+
            '       \"priority\":\"Low\",'+
            '       \"ordering_practice_site_type\":\"\",'+
            '       \"qualifying_target_alts\":['+
            '           {'+
            '               \"gene_name":"MET",'+
            '               \"description":"",'+
            '               \"secondary_label":"Amplification",'+
            '               \"mutation_frequency":"++",'+
            '               \"alt_string":"MET Amplification ++",'+
            '               \"alt_type":"cnv"'+
            '           },'+
            '           {'+
            '               \"gene_name":"PDGFRA",'+
            '               \"description":"",'+
            '               \"secondary_label":"Amplification",'+
            '               \"mutation_frequency":"++",'+
            '               \"alt_string":"PDGFRA Amplification ++",'+
            '               \"alt_type":"cnv"'+
            '           },'+
            '           {'+
            '               \"gene_name":"KIT",'+
            '               \"description":"",'+
            '               \"secondary_label":"Amplification",'+
            '               \"mutation_frequency":"++",'+
            '               \"alt_string":"KIT Amplification ++",'+
            '               \"alt_type":"cnv"'+
            '           }'+
            '       ],'+
            '       \"pods":['+
            '       ],'+
            '       \"referral_sent\":\"No\",'+
            '       \"referred\":\"No\",'+
            '       \"request_id\":\"A79194\",'+
            '       \"show_to_customer\":\"Yes\",'+
            '       \"trial_id\":\"a1D3400000DtI8jEAF\",'+
            '       \"trial_name\":\"Mirati 516\",'+
            '       \"updated_at\":\"2018-04-26T23:16:59.000-07:00\",'+
            '       \"updated_at_time_ago\":\"about 11 hours ago at 11:16PM\"'+
            '   }';


    @IsTest
    private static void testParse(){
        MatchRecordResponse obj = MatchRecordResponse.parse(jsonResponse);
        System.assert(obj != null);
    }
}