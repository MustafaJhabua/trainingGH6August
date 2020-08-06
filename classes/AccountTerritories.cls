public class AccountTerritories {
    private static String txtAccountExecutive = 'Missing Account Executive';
    private static String txtDistrict = 'Missing District';
    private static String txtDirector = 'Missing Director';

    public static void setAccountTerritories(List<Account> TriggerNew) {
        Set<Id> keyUserId = new Set<Id>();     
    
        for(Account acc: TriggerNew) {
            keyUserId.add(acc.OwnerId);
        }
    
        Map<Id, User> mapUser = new Map<Id, User>([Select Id, UserRoleId from User where Id= :keyUserId]);
        Map<Id, UserRole> mapRole = new Map<Id, UserRole>([Select Id, Name, ParentRoleId from UserRole]);
    
        for(Account a: TriggerNew) {
            txtAccountExecutive = 'Missing Account Executive';
            txtDistrict = 'Missing District';
            txtDirector = 'Missing Director';            

            User Owner = mapUser.get(a.OwnerId);       
            UserRole OwnerRole = mapRole.get(Owner.UserRoleId);
            if( OwnerRole <> null ) {
                getTerritory(OwnerRole.Name);

                UserRole ParentRole = mapRole.get(OwnerRole.ParentRoleId);
                if( ParentRole <> null ) {
                    getTerritory(ParentRole.Name);

                    UserRole ParentParentRole = mapRole.get(ParentRole.ParentRoleId);
                    if( ParentParentRole <> null ) {
                        getTerritory(ParentParentRole.Name);
                    }
                }
            }

            a.Account_Executive__c = txtAccountExecutive;
            a.District__c = txtDistrict;
            a.Director__c = txtDirector;
        }
    }
    
    public static void getTerritory(String txtRoleName) {
        if(txtRoleName.contains('Account Executive')) {
            txtAccountExecutive = txtRoleName;
        } else if(txtRoleName.contains('District')) {
            txtDistrict = txtRoleName;
        } else if(txtRoleName.contains('Director')) {
            txtDirector = txtRoleName;        
        }
    }
}