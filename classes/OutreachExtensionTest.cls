@isTest(SeeAllData=TRUE)
public class OutreachExtensionTest {
    static testMethod void outreachExtenstion(){
        test.startTest();
        Match_Record__c mr = new Match_Record__c();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(mr);
        OutreachExtension oe = new OutreachExtension(sc);
        
        test.stopTest();
        
        OutreachExtension.restMethod();
        MatchExtension.restMethod();
        
        //PageReference pageRef = Page.AccountPlan;
        //pageRef.getParameters().put('id', String.valueOf(mr.Id));
        //Test.setCurrentPage(pageRef);
    }
}