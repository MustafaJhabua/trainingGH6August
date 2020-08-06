@IsTest
private class LogTest {

    @IsTest
    public static void logTest() {
        Log.push('MyClass.methodA');
        TestFactory.createSObject(new Account(), true);
        //insert new Account(Name = 'Test');
        Log.push('MyClass.methodB');
        Log.message('Doing something');
        //insert new Account(Name = 'Test');
        TestFactory.createSObject(new Account(), true);
        Log.pop();
        List<Account> accounts = [SELECT Id FROM Account];
        Log.message('Doing something more');
        Log.pop();
    }
}