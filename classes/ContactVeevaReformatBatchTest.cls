@isTest
public class ContactVeevaReformatBatchTest{
    @isTest
    public static void test1(){
        List<Contact> conList = new List<Contact>();
        
        Account acc = new Account();
        acc.name = 'Test Account Name';
        insert acc;
        
        for(integer i = 0 ; i < 10 ; i++){
        	Contact con = new Contact();
            con.LastName = 'Test Contact last Name - '+ i;
            con.AccountId = acc.Id;
            con.Veeva_ID__c = 'v_8877889900';
            conList.add(con);
        }
        insert conList;
        
        Database.executeBatch(new ContactVeevaReformatBatch());
    }
}