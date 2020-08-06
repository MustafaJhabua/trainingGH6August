public with sharing class NewContactController {
    @AuraEnabled(cacheable=true)
    public static List<Account_Integration_Tasks__c> getChildRecords(String supervisor) {
		System.debug('Sup >> '+supervisor);
        List<Contact> cList = new List<Contact>();
        cList = [SELECT Id, Integration_Contact_Type__c, Care_Team_Member_Roles__c  FROM Contact WHERE Id =: supervisor];
        
        List<Account_Integration_Tasks__c> actList = new List<Account_Integration_Tasks__c>();
        
		List<Account_Integration_Tasks__c> actListFinal = new List<Account_Integration_Tasks__c>();
        if( cList.size() > 0 ) {
            if( cList[0].Integration_Contact_Type__c == 'Care Team Member' ) {
                actList = [SELECT Id, Physician__c, Care_Team_Member__r.Care_Team_Member_Roles__c, Care_Team_Member__c,Integration_Question__r.Support_Team_Care_Team_Role__c, Date_Completed__c, Mark_Completed__c, Name FROM Account_Integration_Tasks__c WHERE Care_Team_Member__c =: supervisor];
                for( Account_Integration_Tasks__c acc : actList ) {
                    if( cList[0].Care_Team_member_Roles__c.contains(acc.Integration_Question__r.Support_Team_Care_Team_Role__c ) ) {
                        actListFinal.add(acc);
                    }
                }
            }
            else{
                actList = [SELECT Id, Physician__c, Care_Team_Member__r.Care_Team_Member_Roles__c, Care_Team_Member__c,Integration_Question__r.Support_Team_Care_Team_Role__c, Date_Completed__c, Mark_Completed__c, Name FROM Account_Integration_Tasks__c WHERE Physician__c =: supervisor];
                actListFinal.addAll(actList);
            }
        }
        system.debug('actListFinal>>'+actListFinal);
        return actListFinal;
        // return [SELECT Id, Care_Team_Member__c, Care_Team_Member_Role__c, Date_Completed__c, Mark_Completed__c, Name FROM Account_Integration_Tasks__c WHERE Physician__c =: supervisor];
    }
    @AuraEnabled(cacheable=true)
    public static List<Object>groToolRecords(String filter) {
        String usersRegion;
        usersRegion = [SELECT Region__c FROM User WHERE Id =: filter].Region__c;
        // return [SELECT Id, Name, Integrated_formula__c, Account.Name  FROM Contact WHERE GRO_Tool__c = true AND Region__c =: usersRegion AND Integration_Contact_Type__C = 'Physician'];
        Map<String, Contact> accountContactMap = new Map<String, Contact>();
        Map<Id, String> contactVsAffilation = new Map<Id, String>();
        List<Contact> contactList = new List<Contact>();
        List<Account> accountList = new List<Account>();
        List<Affilation__c> affilationList = new List<Affilation__c>();
        List<Group> groupList = new List<Group>();
        groupList = [SELECT Id, Name FROM Group WHERE DeveloperName='GRO_Leadership'];
        if( groupList.size() > 0 ) {
            List<GroupMember> groupMemberList = new List<GroupMember>();
            groupMemberList = [SELECT Id, UserOrGroupId FROM GroupMember WHERE GroupId =: groupList[0].Id];
            if( groupMemberList.size() > 0 ) {
                List<String> groupedUser = new List<String>();
                for ( GroupMember gm : groupMemberList ) {
                    groupedUser.add(gm.UserOrGroupId);
                }
                if( groupedUser.contains(UserInfo.getUserId()) ) {
                    contactList = [SELECT Id, Name, Account.Name, (SELECT Account__c, Account__r.Name FROM Affilations__r where Account__r.Account_Integration_Target__C = true), Integrated_formula__c, AccountId, Account.Account_Integration_Target__c  FROM Contact WHERE GRO_Tool__c = true AND Integration_Contact_Type__C = 'Physician'];
                }
                else
                {
                    contactList = [SELECT Id, Name, Account.Name, (SELECT Account__c, Account__r.Name FROM Affilations__r where Account__r.Account_Integration_Target__C = true), Integrated_formula__c, AccountId, Account.Account_Integration_Target__c  FROM Contact WHERE GRO_Tool__c = true AND Region__c =: usersRegion AND Integration_Contact_Type__C = 'Physician'];
                }
            }
            else
            {
                contactList = [SELECT Id, Name, Account.Name, (SELECT Account__c, Account__r.Name FROM Affilations__r where Account__r.Account_Integration_Target__C = true), Integrated_formula__c, AccountId, Account.Account_Integration_Target__c  FROM Contact WHERE GRO_Tool__c = true AND Region__c =: usersRegion AND Integration_Contact_Type__C = 'Physician'];
            }
        }
        else
        {
            contactList = [SELECT Id, Name, Account.Name, (SELECT Account__c, Account__r.Name FROM Affilations__r where Account__r.Account_Integration_Target__C = true), Integrated_formula__c, AccountId, Account.Account_Integration_Target__c  FROM Contact WHERE GRO_Tool__c = true AND Region__c =: usersRegion AND Integration_Contact_Type__C = 'Physician'];
        }
        System.debug('CT >> '+contactList);
        System.debug('CT Size >> '+contactList.size());
        if( contactList.size() > 0 ) {
            for( Contact c : contactList ) {
                String accountSet;
                if( c.Account.Account_Integration_Target__c ) {
                 	accountSet = c.Account.Name;
                }
                else
                {
                    if( c.Affilations__r.size() > 0 && accountSet == null ) {
                        for( Affilation__c a : c.Affilations__r ) {
                            accountSet = a.Account__r.Name;
                            break;
                        }
                    }   
                }
                contactVsAffilation.put(c.Id, accountSet);
            }
        }
        List<Object> selfCreatedList = new List<Object>();
        if( contactList.size() > 0 ) {
            for( Contact c : contactList ) {
                GROClassCustom gcc = new GROClassCustom();
                gcc.id = c.Id;
                gcc.Name = c.Name;
                gcc.percentage = c.Integrated_formula__C;
                gcc.widthPercentage = 'width: '+c.Integrated_formula__C+'%;';
                gcc.AccountName = contactVsAffilation.get(c.Id);
                selfCreatedList.add(JSON.deserializeUntyped(JSON.serialize(gcc)));
            }
        }
        return selfCreatedList;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact>getChildContacts(String filter) {
          return [SELECT Id, Name, Care_Team_Member_Roles__c FROM Contact WHERE Care_Team_Member__c =: filter];
    }
    @AuraEnabled(cacheable=true)
    public static String getCareTeamMemberAccountId(String filter) {
        String finalAccount = '';
        String finalAccountName = '';
        Set<String> accounts = new Set<String>();
		List<Contact> contactList = new List<Contact>();
        List<Account> accountList = new List<Account>();
        List<Affilation__c> affilationList = new List<Affilation__c>();
        affilationList = [SELECT Account__c FROM Affilation__c WHERE Contact__c =: filter];
        System.debug('Aff List >>'+affilationList);
        if( affilationList.size() > 0 ) {
            for( Affilation__c aff : affilationList ) {
                accounts.add(aff.Account__c);
            }
        }
        contactList = [SELECT AccountId FROM Contact WHERE Id =: filter];
        if( contactList.size() > 0 ) {
            for( Contact c : contactList ) {
                accounts.add(c.AccountId);
            }
        }
        if( accounts.size() > 0 ) {
            accountList = [SELECT Id, Account_Integration_Target__c FROM Account WHERE Id IN :accounts];
            System.debug('Acc List >> '+accountList);
            if( accountList.size() > 0 ) {
                for( Account acc : accountList ) {
                    if( acc.Account_Integration_Target__c ) {
                        finalAccount = acc.Id;
                    }
                }
            }
        }
        if( finalAccount != '' ) {
            finalAccountName = [SELECT Id FROM Account WHERE Id =: finalAccount].Id;
        }
		return finalAccountName;
    }
    @AuraEnabled(cacheable=true)
    public static String getCareTeamMemberAccount(String filter) {
        String finalAccount = '';
        String finalAccountName = '';
        Set<String> accounts = new Set<String>();
		List<Contact> contactList = new List<Contact>();
        List<Account> accountList = new List<Account>();
        List<Affilation__c> affilationList = new List<Affilation__c>();
        affilationList = [SELECT Account__c FROM Affilation__c WHERE Contact__c =: filter];
        System.debug('Aff List >>'+affilationList);
        if( affilationList.size() > 0 ) {
            for( Affilation__c aff : affilationList ) {
                accounts.add(aff.Account__c);
            }
        }
        contactList = [SELECT AccountId FROM Contact WHERE Id =: filter];
        if( contactList.size() > 0 ) {
            for( Contact c : contactList ) {
                accounts.add(c.AccountId);
            }
        }
        if( accounts.size() > 0 ) {
            accountList = [SELECT Id, Account_Integration_Target__c FROM Account WHERE Id IN :accounts];
            System.debug('Acc List >> '+accountList);
            if( accountList.size() > 0 ) {
                for( Account acc : accountList ) {
                    if( acc.Account_Integration_Target__c ) {
                        finalAccount = acc.Id;
                    }
                }
            }
        }
        if( finalAccount != '' ) {
            finalAccountName = [SELECT Name FROM Account WHERE Id =: finalAccount].Name;
        }
		return finalAccountName;
    }
    @AuraEnabled(cacheable=true)
    public static String getIntegrationContactType(String filter) {
        String integrationContactType = '';
        String findType = [SELECT Integration_Contact_Type__c FROM Contact WHERE Id =: filter].Integration_Contact_Type__c;
        if( findType != null ) {
            integrationContactType = findType;
        }
        return integrationContactType;
    }
    @AuraEnabled(cacheable=true)
    public static List<Task> getActivityTask(String filter) {
        return [SELECT Id, Subject, Priority, Status, ActivityDate, CreatedDate FROM Task WHERE WhoId =: filter];
    }
    public class GROClassCustom {
        public Id Id;
        public String Name;
        public String AccountName;
        public Decimal percentage;
        public String widthPercentage;
    }
}