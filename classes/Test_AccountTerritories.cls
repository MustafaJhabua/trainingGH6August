@IsTest
public class Test_AccountTerritories {

    static testMethod void testAccountTerritories() {

        UserRole DirectorRole = (UserRole) TestFactory.createSObject(new UserRole(Name = 'Director'), true);
        UserRole DistrictRole = (UserRole) TestFactory.createSObject(new UserRole(Name = 'District', ParentRoleId = DirectorRole.Id), true);
        UserRole AERole = (UserRole) TestFactory.createSObject(new UserRole(Name = 'Account Executive', ParentRoleId = DistrictRole.Id), true);
        User AEUser = (User) TestFactory.createSObject(new User(FirstName = 'Test',
                LastName = 'AE',
                UserRoleId = AERole.Id,
                Username = 'ae@test.com.dev01',
                Email = 'ae@test.com.dev01',
                Alias = 'ae',
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'ISO-8859-1',
                ProfileId = '00e80000001G94RAAS',
                LanguageLocaleKey = 'en_US'
        ), true);

        Test.startTest();
        System.runAs(AEUser) {
            TestFactory.createSObjectList(new Account(OwnerId = AEUser.Id), 200, true);
        }
        Test.stopTest();


    }
}