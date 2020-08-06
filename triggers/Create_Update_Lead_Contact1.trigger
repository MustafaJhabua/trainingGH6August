trigger Create_Update_Lead_Contact1 on Lead (after insert){
    
    List<Contact> newConList = new List<Contact>();
    List<Id> leadIdsToDelete = new List<Id>();
    Map<String,Id> npiWithLead = new Map<String,Id>();
    Map<String,Lead> updateLead = new Map<String,Lead>(); 
    
    for (Lead ld : Trigger.new) {
        if(ld.NPI_Number__c != null)
        {
        npiWithLead.put(ld.NPI_Number__c,ld.id);
        updateLead.put(ld.NPI_Number__c,ld);
        }
    }
    
    /*Checks for existing contact with matched NPI number and related to 
    Account with account type 'Clinical Account US' and matching Zip postal code .Updates matched Contact Practice name and email with 
    inserted lead practise name & Email */
    if(!npiWithLead.isEmpty()) {
        System.debug(npiWithLead.keySet() +' ________________0');
        System.debug(updateLead.keySet() +' ________________0');
        
        for(Contact con : [SELECT Id,NPI_Number__c,NPI_Matched__c ,account.Account_Type__c,account.BillingPostalCode,
                           (SELECT Id,account__r.BillingPostalCode,account__r.Account_Type__c FROM Affilations__r 
                            )
                           FROM Contact 
                           WHERE NPI_Number__c IN: npiWithLead.keySet()
                           ORDER BY Createddate DESC ]) {
            System.debug(con.account.BillingPostalCode + updateLead.get(con.NPI_Number__c).Postalcode +'________________1');
              Boolean IsSameZipCode = false ;
              for(Affilation__c af: con.Affilations__r)  
              {
                  if(af.account__r.BillingPostalCode == updateLead.get(con.NPI_Number__c).Postalcode && af.account__r.Account_Type__c =='Clinical Account US')
                    IsSameZipCode = true ;  
              }
            if((con.account.BillingPostalCode == updateLead.get(con.NPI_Number__c).Postalcode && con.account.Account_Type__c=='Clinical Account US') || IsSameZipCode==true){
                con.NPI_Matched__c = true ;
                con.Primary_Cancer_Type__c = updateLead.get(con.NPI_Number__c).Primary_Cancer_Type__c;
                con.Practice_Contact_First_Name__c = updateLead.get(con.NPI_Number__c).Practice_Contact_First_Name__c; 
                con.Practice_Contact_Last_Name__c = updateLead.get(con.NPI_Number__c).Practice_Contact_Last_Name__c;
                con.Practice_Office_Contact_Email__c = updateLead.get(con.NPI_Number__c).Practice_Office_Contact_Email__c;
                con.Request_a_Kit_Details__c = updateLead.get(con.NPI_Number__c).Request_a_Kit_Details__c;
                newConList.add(con);
                leadIdsToDelete.add(npiWithLead.get(con.NPI_Number__c));
            }
        }
        if(!newConList.isEmpty()) {
            update newConList; 
        }
        
        List<Lead> updateLeads = new List<Lead>();
        List<Lead> leadtoUpdate = new List<Lead>();
        leadtoUpdate = [SELECT Id,Inquiry_Type__c from Lead where Id IN :npiWithLead.values() AND Id NOT IN :leadIdsToDelete];
        for(Lead ld : leadtoUpdate){
            ld.NPI_Not_Matched__c = true;
            updateLeads.add(ld);
        }    
        System.debug(leadtoUpdate +'________________0');
        System.debug(updateLeads +'________________0');        
        if(!updateLeads.isEmpty())
            update updateLeads;
        if(!leadIdsToDelete.isEmpty()) {
            List<Lead> delLead = [SELECT id from Lead where id IN :leadIdsToDelete];
            delete delLead; System.debug('Lead deleted');
        }
    }
}