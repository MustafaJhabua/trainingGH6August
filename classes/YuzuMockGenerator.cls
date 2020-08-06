@IsTest
public class YuzuMockGenerator implements HttpCalloutMock {

    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"status":"Success","data":{"scheduling_url": "https://proto.studypages.com/gh_availability/111_random_id_goes_here_111/"}');
        res.setStatusCode(200);
        return res;
    }
}