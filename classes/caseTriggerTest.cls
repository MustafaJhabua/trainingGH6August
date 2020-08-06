@isTest
public class caseTriggerTest{

public static testmethod  void caseCreation(){
case caseRef= new case(Issue__c='Billing',TRF_Type__c='MD demo - verify',Status='new');
insert caseRef;
caseRef.subject='hasdhas';
update caseRef;
delete caseRef;
}
}