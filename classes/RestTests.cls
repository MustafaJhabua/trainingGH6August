@istest
public class RestTests {
    static testMethod void callMethods(){
        List <Match_Record__c> mrList = new List <Match_Record__c>();
        Match_Record__c mr = new Match_Record__c();
        mr.Name = '1234';
        mr.Match_ID__c = '1234';
        mrList.add(mr);
        insert mrList;
        
        Test.startTest();

            RestResponse res = new RestResponse();
            RestRequest req = new RestRequest(); 			
			
            req.httpMethod = 'GET';
            req.addHeader('Content-Type', 'application/json'); // Add a JSON Header as it is validated 
            req.requestURI = '/services/apexrest/mrCreate/doPost' ;  
            RestContext.request = req;
            RestContext.response = res;

			
		Test.stopTest();   
        
    	mrCreate.restMethod();
    	mrUpdate.restMethod();
    	mrResponse.restMethod();
    }
}