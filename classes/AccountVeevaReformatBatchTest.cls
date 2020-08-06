@isTest
public class AccountVeevaReformatBatchTest{
    @isTest
    public static void test1(){
        List<Account> accList = new List<Account>();
        
        for(integer i = 0 ; i < 10 ; i++){
        	Account acc = new Account();
            acc.Name = 'Test Account Name - '+ i;
            acc.Veeva_ID__c = 'v_8877889900';
            accList.add(acc);
        }
        insert accList;
        
        Database.executeBatch(new AccountVeevaReformatBatch());
    }
}