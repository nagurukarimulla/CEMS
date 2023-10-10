public class ContactsHelper {
    Public void CreateNewContact()    
    {
        Contact con = new Contact();  
        
       		con.FirstName = 'Apex';
        	con.LastName = 'Contact Record';
        	con.Title = 'Project Manager';
        	con.Email = 'sample@gmail.com';
        	con.Phone = '9900998877';
        	con.Fax = '9900667788';
        	con.LeadSource = 'Web';
        	con.MailingCity = 'Hyderabad';
        	con.MailingState = 'Telangana';
        	con.MailingCountry = 'India';
        
        insert con;
        
        if(con.Id != null)
        {
            system.debug('Contact Record Created With Id ....: '+ con.id);
        }        
    }
}