@RestResource(urlMapping='/pushTopicCreation/*')

global with sharing class portalCreateRecord {

   @HttpPost

    global static String createPushTopic(String query,string pushtopicname) {
   try{
        PushTopic pushTopic = new PushTopic();
        pushTopic.Name = pushtopicname;
        pushTopic.Query = query;
        pushTopic.ApiVersion = 47.0;
        pushTopic.NotifyForOperationCreate = true;
        pushTopic.NotifyForOperationUpdate = true;
        pushTopic.NotifyForOperationUndelete = true;
        pushTopic.NotifyForOperationDelete = true;
        pushTopic.NotifyForFields = 'Referenced';
        insert pushTopic;

       return 'Success';
      }
      
      catch(exception ex){
      return 'Error :'+ex.getMessage();
      }

    }

}