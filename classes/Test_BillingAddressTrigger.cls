@IsTest
public class Test_BillingAddressTrigger {

    static testMethod void testAccountTrigger(){
        List<Account> lstAcc = TestFactory.createSObjectList(new Account(),200,true);
        update lstAcc;
    }   
}