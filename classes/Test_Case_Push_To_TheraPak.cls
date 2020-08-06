@IsTest(SeeAllData=false)
public class Test_Case_Push_To_TheraPak {

    static testMethod void PushToTheraPak() {
        List<Account> lstAcc = Test_Data_Factory.createAccounts(10, null);
        insert lstAcc;
        
        List<Case> lstCase = Test_Data_Factory.createCases(lstAcc, '01280000000HmU6');
        
        for(Case c: lstCase) {
            c.Push_To_TheraPak__c = true;
            c.Kits_Clinical_domestic__c = 1;
            c.Kits_Clinical_int_l__c = 1;
        }
        
        insert lstCase;
    }
}