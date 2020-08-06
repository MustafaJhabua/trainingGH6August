@IsTest
private class RecordUpdateBatchTest {

    private static final String QUERY = 'SELECT Id, Name FROM Account LIMIT 1';
    private static final String FIELDNAME = 'Name';
    private static final String FIELDVALUE = 'Test Value';

    @TestSetup
    private static void SetupObjects() {
        TestFactory.createSObject(new Account(), true);
    }

    @IsTest
    private static void test_RecordUpdateBatch() {
        RecordUpdateBatch b = new RecordUpdateBatch(QUERY, FIELDNAME, FIELDVALUE);
        Database.executeBatch(b, 200);
    }
}