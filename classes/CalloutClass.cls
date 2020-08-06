public class CalloutClass {
    public static HttpResponse getInfoFromExternalService() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ConfigService.matchPortalEndpoint + '/api/match_service/matches?match_id=name&token='+ConfigService.matchPortalToken);
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
        return res;
    }
}