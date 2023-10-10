@RestResource(urlMapping='/LeadServicePatch/*')
global class LeadServicePatch {
 @httpPatch

    global static string updateLeadEmail(string newEmail){

        string respMessage;

        try{

            RestRequest req = RestContext.request;

            string requestURI = req.requestURI;

            string leadid = requestURI.substring(requestURI.lastIndexOf('=')+1);

            lead mylead = [Select id,email from lead where id=:leadid];

            if(mylead!=NULL && mylead.Email !=newEmail){

                string oldemail = mylead.Email;

                mylead.email = newEmail;

                update mylead;

                respMessage = 'Lead updated from old email '+oldemail +' with new email as '+newEmail;

            }

            else{

                respMessage = 'Currently this lead is having same email address '+newEmail;

            }

        }

        catch(Exception ex){

           respMessage ='Exception occured during lead update '+ex.getMessage();

        }

        return respMessage;

    }
}