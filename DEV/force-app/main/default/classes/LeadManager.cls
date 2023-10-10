global class LeadManager {
    webservice static string createNewLead(string leadFirstName,string leadLastName,string LeadCompanyName,string leadEmail,string leadphone){
        try{
            Lead ld = new lead();
            ld.FirstName = leadFirstName;
            ld.LastName = leadLastName;
            ld.Company  = LeadCompanyName;
            ld.Email    = leadEmail;
            ld.Phone    = leadphone;
            insert ld;
            return ld.id;
        }
        catch(exception ex){
            return 'Error during processing';
        }
    }
}






/*

//invoke my partenr WSDL class login

//soap class

//partnerSoapSforceCom class

//login(user name and passowrd)



string username = 'naguruk@cittacore.com';

string password = 'Nkarim786zDhzHRRC7bHbUnFNHmBQKm1Z';

partnerSoapSforceCom3.soap soapObj = new partnerSoapSforceCom3.soap();

partnerSoapSforceCom3.LoginResult logRes =soapObj.login(username,password);

system.debug('logRes'+logRes);

//step 2 - sessionHeader objec to pass session id

SoapLeadManager.SessionHeader_element sessionObj = new SoapLeadManager.SessionHeader_element();

sessionObj.sessionId = logRes.sessionId;

//step 3- session obj with soap call

SoapLeadManager.LeadManager leadserveice = new SoapLeadManager.LeadManager();

leadserveice.SessionHeader = sessionObj;

string response = leadserveice.createNewLead('naguru','karimulla','CittaCore','karimnaguru@gmail.com','8712314388');

system.debug('response'+response);


*/