@isTest
private class SQSTest {
	
	@isTest
    public static void testConstructor() {
        SQS sqs = new SQS('test', 'test');
    }

	@isTest(SeeAllData=true)	
	public static void test() {
		Test.setMock(HttpCalloutMock.class, new SQSMockGenerator());
		SQS sqs = new SQS('access','secret');
	    sqs.baseUrl = 'sqs.us-east-1.amazonaws.com';
	    sqs.queuePath = '/764253764907/ra-sqs-test-1'; 
	    sqs.method = 'GET';
	    sqs.parameters.put('Action', 'SendMessage');
	    sqs.parameters.put('MessageBody', 'THIS IS A TEST');
	    sqs.sendMessage();
	}
	
}