global class SQS{

    public SQS() {
        AWS_Credentials__c awsConfigSettings = AWS_Credentials__c.getInstance();
        this.accessKey = awsConfigSettings.Physician_Update_Access_Key__c;
        this.secret = awsConfigSettings.Physician_Update_Secret_Key__c;
    }
    
    public SQS(String accessKey, String secret) {
        this.accessKey = accessKey;
        this.secret = secret;
    }

    public String lastStatus { get; set; }
    public Integer lastStatusCode { get; set; }
    public String lastResponseBody { get; set; }

    public String baseUrl { get; set; }
    public String queuePath{ get; set; }
    public String method { get; set; }
    public String action { get; set; }
    private String accessKey { get; set; }
    private String secret { get; set; }

 
    private String getCurrentDate() {
        return DateTime.now().formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
    }

    public Map<String, String> parameters {
        get {
            if(parameters == null) {
                parameters = new Map<String, String>();
                parameters.put('AWSAccessKeyId', this.accessKey);
                parameters.put('Timestamp',encode(getCurrentDate()));
                parameters.put('SignatureVersion', '2');
                parameters.put('SignatureMethod', 'HmacSHA256');
                parameters.put('Version', '2011-10-01');
            } 
            return parameters;
        }
        set;
    }
 
    public void sendMessage() {
         
        //The string to sign has to be sorted by keys
        List<String> sortedKeys = new List<String>();
        sortedKeys.addAll(parameters.keySet());
        sortedKeys.sort();
 
        String toSign = 'GET\n' + baseUrl +'\n'+queuePath+'\n';
        Integer p = 0;
        for (String key : sortedKeys) {
            String value = parameters.get(key);
            if (p > 0) {
                toSign += '&';
            }
            p++;
            toSign += key+'='+value;
        }
        parameters.put('Signature',getMac(toSign,secret));
 
        String url = 'https://'+ baseUrl+queuePath+'?';
        p = 0;
        for (String key : parameters.keySet()) {
            if (p > 0) {
                url += '&';
            }
            p++;
            url += key+'='+parameters.get(key);
        }
 
        HttpRequest req = new HttpRequest();
        req.setEndPoint(url);
        req.setMethod('GET');
        Http http = new Http();
        try {
            HttpResponse response = http.send(req);
            system.debug(response);
            this.lastStatus = response.getStatus();
            this.lastStatusCode = response.getStatusCode();
            this.lastResponseBody = response.getBody();
        
        system.debug(this.lastResponseBody);
        }
        catch (System.CalloutException e) {
            System.debug('ERROR: ' + e);
        }
 
    }
    
    //Amazon wants + and * to be escaped, but not ~
    public static String encode(String message){
        return EncodingUtil.urlEncode(message,'UTF-8').replace('+', '%20').replace('*', '%2A').replace('%7E','~');
    }
 
    private String getMac(String RequestString, String secretkey) {
        String algorithmName = 'HmacSHA256';
        Blob input = Blob.valueOf(RequestString);
        Blob key = Blob.valueOf(secretkey);
        Blob signing =Crypto.generateMac(algorithmName, input, key);
        return EncodingUtil.urlEncode(EncodingUtil.base64Encode(signing), 'UTF-8');
    }
 
}