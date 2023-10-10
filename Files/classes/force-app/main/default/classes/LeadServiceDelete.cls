@RestResource(urlMapping='/LeadServiceDelete/*')
global class LeadServiceDelete {
@httpDelete

    global static string deleteMatchingLead(){

        string responseMessage;

        integer leadCount =0;

        try{

            RestRequest req = RestContext.request;

            RestResponse res = RestContext.response;

            system.debug('req.requestURI'+req.requestURI);

            string requestURI = req.requestURI;       

            string leadName ='%'+requestURI.substring(requestURI.lastIndexOf('=')+1)+'%';

            system.debug('leadName'+leadName);

            list<lead> leadlist = [SELECT Id,Name,Email,Phone,Company,MobilePhone from lead where Name like :leadName];

            if(leadlist!=NULL && leadlist.size()>0){

                leadCount = leadlist.size();

            }

            delete leadlist;

        }

        catch(Exception ex){

            responseMessage =  'Exception occured during delete =>'+ex.getMessage();   

        }

        responseMessage =  'Lead deleted sucesfully => lead deleted count : '+leadCount;

        return responseMessage;
    }
}