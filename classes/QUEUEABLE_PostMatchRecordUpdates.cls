public with sharing class QUEUEABLE_PostMatchRecordUpdates implements Queueable, Database.AllowsCallouts{
    public List<String> matchRecordTokens = new List<String>();

    public QUEUEABLE_PostMatchRecordUpdates(List<String> matchRecordTokens){
        this.matchRecordTokens = matchRecordTokens;
    }
    public void execute(QueueableContext context){
        apiCallout(matchRecordTokens[0]);
        matchRecordTokens.remove(0);
        if(matchRecordTokens.size()>0 && Limits.getQueueableJobs() == 0 && !Test.isRunningTest() &&!System.isQueueable() && Limits.getQueueableJobs() == 0){
            System.enqueueJob(new QUEUEABLE_PostMatchRecordUpdates(matchRecordTokens));
        }
    }

    /****Callout to update Portal API*****/
    public static void apiCallout(String postAPI){
        //check string was passed
        System.debug('Im being called = ' + postAPI);
        MatchRecordTriggerHelper.inFutureContext = true;
        //post URL to portal
        try {
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http http = new Http();

            req.setEndpoint(postAPI);
            req.setMethod('POST');
            req.setBody('test');

            res = http.send(req);
            System.debug('If you get 200 response, you are good!  Response: ' + res.getStatusCode());
        }
        catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
        }
    }
}