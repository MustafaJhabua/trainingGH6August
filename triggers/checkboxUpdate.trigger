trigger checkboxUpdate on Contact (before Update) {
    Set<Id> finalAccountIds = new Set<Id>();
    Set<Id> contactIds = new Set<Id>();
    Map<Id, Account> accountMap = new Map<Id, Account>();
    Map<Contact, Set<Id>> contactAccountMap = new Map<Contact, Set<Id>>();
    Map<Id, Boolean> contactCheckbox = new Map<Id, Boolean>();
    for (Contact con : trigger.new) {
        contactIds.add(con.Id);
    }
    system.debug('contactIds' + contactIds);

    for (Contact con : [SELECT Id, Affiliate_Account_match__c, AccountId, (SELECT Id, Account__c FROM Affilations__r) FROM Contact WHERE Id IN: contactIds]) {
        Set<Id> accIds = new Set<Id>();
        if (con.AccountId != null) {
        accIds.add(con.AccountId);
        finalAccountIds.add(con.AccountId);
        }
        if (con.Affilations__r.size() > 0) {
            for (Affilation__c aff : con.Affilations__r) {
                accIds.add(aff.Account__c);
                finalAccountIds.add(aff.Account__c);
            }
        }
        contactAccountMap.put(con, accIds);
    }
    system.debug(finalAccountIds);
    system.debug(finalAccountIds.size());
    if(!finalAccountIds.isEmpty())
    {
    system.debug('Enter');
    system.debug(finalAccountIds);
    for ( Account acc : [SELECT Id, Qualified__c FROM Account WHERE Id IN: finalAccountIds]){
        accountMap.put(acc.Id, acc);
    }
    for (Contact con : contactAccountMap.keyset()) {
        Boolean checkboxValue = false;
        if (contactAccountMap.get(con) != null) {
            for (Id accId : contactAccountMap.get(con)) {
                if (accountMap.get(accId).Qualified__c == true){
                    checkboxValue = True;
                }
            }
        }
        con.Affiliate_Account_match__c = checkboxValue;
        contactCheckbox.put(con.Id, checkboxValue);
    }

    for (contact con : trigger.new) {
        if (contactCheckbox.get(Con.Id) != null) {
            con.Affiliate_Account_match__c  = contactCheckbox.get(Con.Id);
        }
    }
    }
}