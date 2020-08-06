public with sharing class VeevaWidgetSearchController{
    public List<Veeva_Configuration__mdt> records {get; set;}
    public VeevaWidgetSearchController(){
        records = [Select ID,
                   MasterLabel,
                   auth_domain__c,
                   password__c,
                   username__c,
                   widget_id__c 
                   from Veeva_Configuration__mdt 
                   where MasterLabel = 'gh_search_widget'];
	}
}