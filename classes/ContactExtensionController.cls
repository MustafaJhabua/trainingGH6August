public class ContactExtensionController {
    public Id contactID {get;set;}
    public String contactVeevaID {get;set;}
    public List<Veeva_Configuration__mdt> records {get; set;}
    
    public ContactExtensionController(ApexPages.StandardController controller) {
        try{
            records = [Select ID,
                       MasterLabel,
                       auth_domain__c,
                       password__c,
                       username__c,
                       widget_id__c 
                       from Veeva_Configuration__mdt 
                       where MasterLabel = 'gh_dcr_widget'];
            
            Contact con = new Contact();
            contactID = controller.getId();
            List<Contact> conList = [Select Id, Veeva_ID__c from Contact where ID =: contactID];
            if(conList != null && conList.size() > 0){
                contactVeevaID = conList[0].Veeva_ID__c;
                //if(contactVeevaID != null && contactVeevaID != ''){
                //contactVeevaID = contactVeevaID.removeStart('v_');
                //}
            }
        }
        catch(Exception e){
            System.debug('Message - '+ e.getMessage());
            System.debug('Stack Trace - '+ e.getStackTraceString());
        }
    }    
}