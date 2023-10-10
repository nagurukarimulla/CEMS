public with sharing class SalesforceCalloutController {
    private static final String ENDPOINT_URL = 'https://cittacoretechnologies-5d-dev-ed.develop.my.salesforce.com';
    private static final String ACCESS_TOKEN = '00D2w00000Fc7tA!AR0AQHd6XhUMtfce0a4Pt8aDFiUyOVnncpiOYicgK7ul0rw7QB3DmusBuQA7EixFxpJEKQOsY2U5RfHDQLeguRKISrdigyB9';

    @AuraEnabled(cacheable=true)
    public static String authenticateUser(String username, String password, String securityToken) {
        String authUrl = ENDPOINT_URL + '/services/oauth2/token';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(authUrl);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody('grant_type=password&client_id=' + EncodingUtil.urlEncode('3MVG9n_HvETGhr3DwFHozf_TEGdrvqoOfGwvDkukskUG7uYnROZ9Oz_WOrf4FpTYUmNiNnpZJ7_UxnozgBeR7', 'UTF-8')
                      + '&client_secret=' + EncodingUtil.urlEncode('AB3B332C43A80BD483E199C36DFDBBAFBE8A1BD574F90B9565201AF30ADF645A', 'UTF-8')
                      + '&username=' + EncodingUtil.urlEncode('nkmvsm@salesforce.com', 'UTF-8')
                      + '&password=' + EncodingUtil.urlEncode('Nkarim786' + 'YDBbj6M3DjjaR2A67UQbD27GO', 'UTF-8'));
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> authResult = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            String accessToken = (String)authResult.get('access_token');
            String instanceUrl = (String)authResult.get('instance_url');
            String userId = getUserId(accessToken, instanceUrl);
            if (userId != null) {
                return 'success';
            }
        }
        return 'failure';
    }

    private static String getUserId(String accessToken, String instanceUrl) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(instanceUrl + '/services/data/v56.0/chatter/users/me');
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> userResult = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            String userId = (String)userResult.get('id');
            return userId;
        }
        return null;
    }

    @AuraEnabled(cacheable=true)
    public static String callout(String operation) {
        // Perform callout based on the operation parameter
        return 'Callout completed.';
    }
}





















































































































































/*
public with sharing class SalesforceCalloutController {
    @AuraEnabled
    public static String authenticateUser(String username, String password, String securityToken, String endpointUrl) {
        //if (username == null || password == null || securityToken == null || endpointUrl == null) {
       //     return 'failure';
       // }
        String authUrl = endpointUrl + '/services/oauth2/token';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(authUrl);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody('grant_type=password&client_id=' + EncodingUtil.urlEncode('3MVG9n_HvETGhr3DwFHozf_TEGdrvqoOfGwvDkukskUG7uYnROZ9Oz_WOrf4FpTYUmNiNnpZJ7_UxnozgBeR7', 'UTF-8')
                      + '&client_secret=' + EncodingUtil.urlEncode('AB3B332C43A80BD483E199C36DFDBBAFBE8A1BD574F90B9565201AF30ADF645A', 'UTF-8')
                      + '&username=' + EncodingUtil.urlEncode('nkmvsm@salesforce.com', 'UTF-8')
                      + '&password=' + EncodingUtil.urlEncode('nkarim786' + 'sALASv8rdUwHlPDWnq3w2qKXI', 'UTF-8'));
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> authResult = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            String accessToken = (String)authResult.get('access_token');
            String instanceUrl = (String)authResult.get('instance_url');
            String userId = getUserId(accessToken, instanceUrl);
            if (userId != null) {
                return 'success';
            }
        }
        return 'failure';
    }

    private static String getUserId(String accessToken, String instanceUrl) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(instanceUrl + '/services/data/v56.0/chatter/users/me');
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> userResult = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            String userId = (String)userResult.get('id');
            return userId;
        }
        return null;
    }

    @AuraEnabled
    public static String callout(String operation) {
        // Perform callout based on the operation parameter
        return 'Callout completed.';
    }
}
*/