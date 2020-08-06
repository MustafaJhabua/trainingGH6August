trigger AccountIntegrationTrigger on Contact (after insert,after update) {
    
    if(Trigger.Isafter && Trigger.IsInsert){
        Set<Id> contactPhysicianSet = new Set<Id>();
        Set<Id> contactCareteamSet = new Set<Id>();
        Map<Id,Map<String,String>> physicianVsCareTeamvsRoleSet = new Map<Id,Map<String,String>>();
        Map<String,String> accountIntTaskVsRole = new Map<String,String>();
        List<Account_Integration_Tasks_Master__c> accountIntTaskMasterList = new List<Account_Integration_Tasks_Master__c>();
        accountIntTaskMasterList = [SELECT Id, Name, Support_Team_Care_Team_Role__c FROM Account_Integration_Tasks_Master__c];
        for(Account_Integration_Tasks_Master__c intMaster:accountIntTaskMasterList){
                if(!accountIntTaskVsRole.containsKey(intMaster.Name)){
                    accountIntTaskVsRole.put(intMaster.Name,intMaster.Support_Team_Care_Team_Role__c);
                }
        }
        for(Contact careTeam: Trigger.New){
            if(careTeam.Care_Team_Member__c == null){
                contactPhysicianSet.add(careTeam.Id);
            }else{
                Set<String> roleSet = new Set<String>();
                String[] roleList = new List<String>();
                if(careTeam.Care_Team_Member_roles__c.contains(';')){
                    roleList= careTeam.Care_Team_Member_roles__c.Split(';');
                    roleSet.addAll(roleList);                
                }else{
                    roleSet.add(careTeam.Care_Team_Member_roles__c);                
                }
                if(!physicianVsCareTeamvsRoleSet.containsKey(careTeam.Care_Team_Member__c)){
                    physicianVsCareTeamvsRoleSet.put(careTeam.Care_Team_Member__c,new Map<String,String>());                
                }
                for(String role:roleSet){
                    if(!physicianVsCareTeamvsRoleSet.get(careTeam.Care_Team_Member__c).ContainsKey(role)){
                        physicianVsCareTeamvsRoleSet.get(careTeam.Care_Team_Member__c).put(role,careTeam.Id);
                    }
                }
            }
        }
        
        system.debug('physicianVsCareTeamvsRoleSet>>'+physicianVsCareTeamvsRoleSet);
        if(contactPhysicianSet.size()>0){
            List<Account_Integration_Tasks__c> accountIntTaskListtoInsert = new List<Account_Integration_Tasks__c>();
            for(Id contactId:contactPhysicianSet){
                for(Account_Integration_Tasks_Master__c intMaster:accountIntTaskMasterList){
                    /*if(!accountIntTaskVsRole.containsKey(intMaster.Name)){
                        accountIntTaskVsRole.put(intMaster.Name,intMaster.Support_Team_Care_Team_Role__c);
					}*/
                    Account_Integration_Tasks__c accIntTask = new Account_Integration_Tasks__c();
                    accIntTask.Name = intMaster.Name;
                    accIntTask.Integration_Question__c = intMaster.Id;
                    accIntTask.Physician__c = contactId;
                    accIntTask.Care_Team_Member_Role__c = intMaster.Support_Team_Care_Team_Role__c;
                    if(physicianVsCareTeamvsRoleSet.containskey(contactId))
                        accIntTask.Care_Team_Member__c = physicianVsCareTeamvsRoleSet.get(contactId).get(intMaster.Support_Team_Care_Team_Role__c);
                    accountIntTaskListtoInsert.add(accIntTask);
                }
            }
            
            insert accountIntTaskListtoInsert;
        }
        
        List<Account_Integration_Tasks__c> accountIntTaskList = new List<Account_Integration_Tasks__c>();
        accountIntTaskList = [SELECT Id, Name, Integration_Question__r.Name, Physician__c, Care_Team_Member__c,Care_Team_Member_Role__c  
                              FROM Account_Integration_Tasks__c where Physician__c in :physicianVsCareTeamvsRoleSet.KeySet()];
        for(Account_Integration_Tasks__c accountIntTask :accountIntTaskList){
            if(physicianVsCareTeamvsRoleSet.get(accountIntTask.Physician__c).ContainsKey(accountIntTaskVsRole.get(accountIntTask.Integration_Question__r.Name))){
                accountIntTask.Care_Team_Member__c = physicianVsCareTeamvsRoleSet.get(accountIntTask.Physician__c).get(accountIntTaskVsRole.get(accountIntTask.Integration_Question__r.Name));
            }
        }
        update accountIntTaskList;
    }
}