@isTest
public class portalTests {
    static testMethod void callTests(){
        PortalQuery.restMethod();
        PortalQuery_Button.restMethod();
        matchBatch_Scheduler.restMethod();
        matchBatch_Batch.restMethod();
        matchBatch_Button.restMethod();
        podQueued.restMethod();
        MockHttpResponseGenerator.restMethod();
    }
}