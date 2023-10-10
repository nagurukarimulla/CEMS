
public with sharing class ImageSearch 
{
    @AuraEnabled(cacheable=true)
    public static void makeCallout(String limitSize)
    {
       // String apikey = 'live_aa9uLEBTEAWuFSZ3KJ2gJ4aV8Shns4CNMEtwSxZAG8IuRUA2EwfbHObi8qUvzE9j';  - Shipla key
      //  String apikey = 'live_CzfpXuKcutuzyHdD4XgPB3RVysAHDRNpqmYdQ83NucllycUfNOrN8K3eGPmzpCCo'; //x-surya key
      //  String endpoint = 'https://api.thecatapi.com/v1/images/search?format=json&limit=2';
        
        ImageSearchAPI__mdt creds = [select apikey__c,endpoint__c from ImageSearchAPI__mdt where MasterLabel ='suryacatapi']; 
        
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(creds.endpoint__c);
        system.debug('*** creds.endpoint__c = '+creds.endpoint__c);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + creds.apikey__c);
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = h.send(request);
        system.debug('**** response.getBody() = '+response.getBody());
        List<ImageSearchVO> getInfo = (List<ImageSearchVO>) JSON.deserialize(response.getBody(), List<ImageSearchVO>.class);
        for(ImageSearchVO iv:getInfo){
            system.debug('url = '+iv.url);
        }

    }
    
}

// IntegrationtoDogApi.makeCallout();*/


  