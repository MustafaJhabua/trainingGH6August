public class AccountExtensionController {
    public Id accountID {get;set;}
    public String accountVeevaID {get;set;}
    public List<Veeva_Configuration__mdt> records {get; set;}
    
    public AccountExtensionController(ApexPages.StandardController controller) {
        try{
            records = [Select ID,
                       MasterLabel,
                       auth_domain__c,
                       password__c,
                       username__c,
                       widget_id__c 
                       from Veeva_Configuration__mdt 
                       where MasterLabel = 'gh_dcr_widget'];
            
            Account acc = new Account();
            accountID = controller.getId();
            
            List<Account> accList = [Select Id, Veeva_ID__c from Account where ID =: accountID];
            if(accList != null && accList.size() > 0){
                accountVeevaID = accList[0].Veeva_ID__c;
                //if(accountVeevaID != null && accountVeevaID != ''){
                //accountVeevaID = accountVeevaID.removeStart('v_');
                //}
            }
        }
        catch(Exception e){
            System.debug('Message - '+ e.getMessage());
            System.debug('Stack Trace - '+ e.getStackTraceString());
        }
    }    
    
}