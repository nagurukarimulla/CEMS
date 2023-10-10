public class sendContactToExternalSystem {
    public void sendContact(String firstName, String lastName, String title, String email, Id id2){
        sendDataToSalesforceChildSystem(id2);
    }
    @future(callout=true)
    public static void sendDataToSalesforceChildSystem(Id id2){
        contact con = [select firstName, lastName, title, email from contact where id =: id2];
        partnerSoapSforceCom1.Soap myPartnerSoap = new partnerSoapSforceCom1.Soap();
        partnerSoapSforceCom1.LoginResult partnerLoginResult = myPartnerSoap.login('nkarimulla0311@gmail.com','nkarim786tUlMGSJWG9JfsMesgYx94ZFc');
        System.debug('Generated Session Id:'+partnerLoginResult.sessionId);
        String sessionIdFetch = partnerLoginResult.sessionId;
        soapSforceComSchemasClassReceivedpar.SessionHeader_element webServiceSessionHeader=new soapSforceComSchemasClassReceivedpar.SessionHeader_element();
        webServiceSessionHeader.sessionId=sessionIdFetch;
        soapSforceComSchemasClassReceivedpar.receivedparametersorg2 obj = new soapSforceComSchemasClassReceivedpar.receivedparametersorg2();
        obj.SessionHeader=webServiceSessionHeader;
        String status = obj.createContactrecord(con.firstname, con.lastname, con.title, con.email);
        System.debug('Status is:'+status);
        
        
    }
}