/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 11-17-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrgToOrgLeadAPIPatch {
    //? What we need do to integrate system 
    //! Do you have end point details 
    //! Do We have Access Token
    
    static Credentials__c crdDetails = [SELECT Id, Name,  UserName__c, Password__c, SecurityToken__c, ClientId__c, ClientSecret__c, TokenURL__c, InstanceEndPoint__c FROM Credentials__c WHERE Name = 'SalesforceCittaCore'];

    @future(callout=true)
    public static void afterInsert(Set<Id> leadIds){
        String accessToken = getAccessToken();
        getInsert(accessToken, leadIds);
    }

    @future(callout=true)
    public static void afterUpdate(Set<Id> leadIds){
        String accessToken = getAccessToken();
        getUpdate(accessToken, leadIds);
    }

    @future(callout=true)
    public static void beforeDelete(Set<Id> leadIds){
        String accessToken = getAccessToken();
        getDelete(accessToken, leadIds);
    }

    public static String getAccessToken(){
        //* Setup your http request
        HttpRequest request = new HttpRequest();
        request.setMethod('POST'); 
        //request.setHeader('Content-Type', 'application/x-www-form-urlencoded'); // application/x-www-form-urlencoded
        request.setBody(
            'grant_type=password'+
            '&client_id='+crdDetails.ClientId__c+
            '&client_secret='+crdDetails.ClientSecret__c+
            '&username='+crdDetails.UserName__c+
            '&password='+crdDetails.Password__c+crdDetails.SecurityToken__c+
            '&Content-Type=application/json'
        );
        request.setEndpoint(crdDetails.InstanceEndPoint__c+'services/oauth2/token');
        Http http = new Http();
        HttpResponse response = http.send(request);
        String accessToken = getAccessToken(response.getBody());
        return accessToken;
    }

    //! Handle the Request Response for AccessToken 
    private static String getAccessToken(String responseBody){
        /*
            {
            "access_token":"SESSION_ID_REMOVED",
            "instance_url":"https://empathetic-hawk-ejdohv-dev-ed.trailblaze.my.salesforce.com",
            "id":"https://login.salesforce.com/id/00D5h000007d3wlEAA/0055h000007XtxpAAC",
            "token_type":"Bearer",
            "issued_at":"1668660012411",
            "signature":"8TdlFFQ/2HMit16DwYOYA/34lqbjp33dPyw97WiO+SM="
            }        
        */
        String accessTokenValue;
        JSONParser parser = JSON.createParser(responseBody);
        while(parser.nextToken() != null){
            if((parser.getCurrentToken() == JSONToken.FIELD_NAME ) && (parser.getText() == 'access_token')){
                system.debug('ACCESS_TOKEN :INSIDE ');
                parser.nextToken();
                accessTokenValue = parser.getText();
            }
        }
        return accessTokenValue;
    }


    public static void getInsert(String accessToken, Set<Id> newLeads){
        List<Lead> newLead = [SELECT Id, LastName, Status, Company FROM Lead WHERE Id IN:newLeads];
        String newLeadBody;
        for(Lead singleLead:newLead){
            newLeadBody = '';
            LeadWrapperClass leadWrapper = new LeadWrapperClass(singleLead.LastName, singleLead.Company, singleLead.Status);
            newLeadBody = JSON.serialize(leadWrapper);
        
            //! its time to send actual data to tager using the accessToken
            String endpoint = crdDetails.InstanceEndPoint__c+'services/data/v56.0/sobjects/Lead';
            HttpRequest getRequest = new HttpRequest();
            getRequest.setHeader('Content-Type', 'application/json');
            getRequest.setHeader('Authorization', 'Bearer '+ accessToken);
            getRequest.setMethod('GET');
            getRequest.setEndpoint(endpoint);

            Http Send = new Http();
            HttpResponse initialResponse = new HttpResponse();
            initialResponse = Send.send(getRequest);

            Id existingLeadId = getExistingLead(singleLead.LastName, initialResponse.getBody());
            //System.debug('lead id ' + existingLeadId);
            HttpRequest frequest = new HttpRequest();
            if(existingLeadId!=null){
                String endPointOfLead = crdDetails.InstanceEndPoint__c+'services/data/v56.0/sobjects/Lead/'+existingLeadId;
                frequest.setHeader('Content-Type', 'application/json');
                frequest.setHeader('Authorization', 'Bearer '+ accessToken);
                frequest.setMethod('PATCH');
                frequest.setBody(newLeadBody);
                frequest.setEndpoint(endPointOfLead);
            }
            else{
                frequest.setHeader('Content-Type', 'application/json');
                frequest.setHeader('Authorization', 'Bearer '+ accessToken);
                frequest.setMethod('POST');
                frequest.setBody(newLeadBody);
                frequest.setEndpoint(endpoint);
            }

            Http finalSend = new Http();
            HttpResponse finalResponse = new HttpResponse();
            finalResponse = finalSend.send(frequest);
            system.debug(finalResponse.getStatusCode()+'+Final Response :'+finalResponse.getBody()); 
            System.debug('Lead has been inserted/updated based on source org'); 
            //System.debug(existingLeadId);
            //system.debug(finalResponse.getStatusCode()+'+Final Response :'+finalResponse.getBody());  
        }  
    }

    public static void getUpdate(String accessToken, Set<Id> updatedLeads){
        List<Lead> updatedLead = [SELECT Id, LastName, Status, Company FROM Lead WHERE Id IN:updatedLeads];
        String newLeadBody;
        for(Lead singleLead:updatedLead){
            newLeadBody = '';
            LeadWrapperClass leadWrapper = new LeadWrapperClass(singleLead.LastName, singleLead.Company, singleLead.Status);
            newLeadBody = JSON.serialize(leadWrapper);
        
            //! its time to send actual data to tager using the accessToken
            String endpoint = crdDetails.InstanceEndPoint__c+'services/data/v56.0/sobjects/Lead';
            HttpRequest getRequest = new HttpRequest();
            getRequest.setHeader('Content-Type', 'application/json');
            getRequest.setHeader('Authorization', 'Bearer '+ accessToken);
            getRequest.setMethod('GET');
            getRequest.setEndpoint(endpoint);

            Http Send = new Http();
            HttpResponse initialResponse = new HttpResponse();
            initialResponse = Send.send(getRequest);

            Id existingLeadId = getExistingLead(singleLead.LastName, initialResponse.getBody());
            //System.debug('lead id ' + existingLeadId);
            HttpRequest frequest = new HttpRequest();
            String endPointOfLead = crdDetails.InstanceEndPoint__c+'services/data/v56.0/sobjects/Lead/'+existingLeadId;
            frequest.setHeader('Content-Type', 'application/json');
            frequest.setHeader('Authorization', 'Bearer '+ accessToken);
            frequest.setMethod('PATCH');
            frequest.setBody(newLeadBody);
            frequest.setEndpoint(endPointOfLead);

            Http finalSend = new Http();
            HttpResponse finalResponse = new HttpResponse();
            finalResponse = finalSend.send(frequest);
            system.debug(finalResponse.getStatusCode()+'+Final Response :'+finalResponse.getBody()); 
            System.debug('Lead has been updated based on source org'); 
        }
    }

    public static void getDelete(String accessToken, Set<Id> delLeads){
        List<Lead> delLead = [SELECT Id, LastName, Status, Company FROM Lead WHERE Id IN :delLeads];
        String newLeadBody;
        for(Lead singleLead:delLead){
            newLeadBody = '';
            LeadWrapperClass leadWrapper = new LeadWrapperClass(singleLead.LastName, singleLead.Company, singleLead.Status);
            newLeadBody = JSON.serialize(leadWrapper);
        
            //! its time to send actual data to tager using the accessToken
            String endpoint = crdDetails.InstanceEndPoint__c+'services/data/v56.0/sobjects/Lead';
            HttpRequest getRequest = new HttpRequest();
            getRequest.setHeader('Content-Type', 'application/json');
            getRequest.setHeader('Authorization', 'Bearer '+ accessToken);
            getRequest.setMethod('GET');
            getRequest.setEndpoint(endpoint);

            Http Send = new Http();
            HttpResponse initialResponse = new HttpResponse();
            initialResponse = Send.send(getRequest);

            Id existingLeadId = getExistingLead(singleLead.LastName, initialResponse.getBody());
            //System.debug('lead id ' + existingLeadId);
            if(existingLeadId!=null){
                System.debug('Lead is present in destination, so dont delete in source org'); 
            }
            
        }
    }

    private static Id getExistingLead(String LastName, String responseBody){
        Id leadId;
        Id existingLeadId;
        String existingleadName;
        JSONParser parser = JSON.createParser(responseBody);
        while(parser.nextToken() != null){
            if((parser.getCurrentToken() == JSONToken.FIELD_NAME ) && (parser.getText() == 'Id')){
                parser.nextToken();
                leadId = parser.getText();
                parser.nextToken();
                if((parser.getCurrentToken() == JSONToken.FIELD_NAME ) && (parser.getText() == 'Name')){
                    parser.nextToken();
                    existingLeadName = parser.getText();
                    if(existingLeadName.equalsIgnoreCase(LastName)){
                        System.debug('Lead Already Present');
                        existingLeadId = leadId;
                    }
                }
            }
        }
        return existingLeadId;
    }

    public class LeadWrapperClass{
        public String LastName;
        public String Status;
        public String Company;
        
	    Public LeadWrapperClass(String LastName, String Company, String Status) {
		    this.LastName = LastName;
            this.Company = Company;
            this.Status = Status;
	    }
    }
}



/*
OrgToOrgLeadAPI.getAccessToken();
*/