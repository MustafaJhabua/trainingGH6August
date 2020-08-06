@IsTest
public class Test_portalCreateRecord  {

    public static testmethod void pushTopicCreate(){
    portalCreateRecord  pc = new portalCreateRecord ();
    portalCreateRecord.createPushTopic('select id ,name from account where name =\'test\'','testPushTopic');
    }
 }