public class LeadHandler 
{
  Public static void CreateLeadRecords()
    {
        List<Lead> lstLeads = new List<Lead>();
        
        // First Lead Record..
        Lead ld = new Lead();
        
          ld.FirstName = 'Arpit';
          ld.LastName = 'Agarwal';
          ld.Title = 'Project Manager';
          ld.Company = 'Cittacore Technology.';
          ld.Status = 'Open - Not Contacted';
          ld.Rating = 'Hot';
          ld.Industry = 'Technology';
          ld.AnnualRevenue = 3700000;
          ld.Phone = '9900887766';
          ld.Fax = '8899887766';
          ld.Email = 'arpita@cittacore.com';
          ld.LeadSource = 'Web';
          ld.City = 'Delhi';
          ld.State = 'NCR';
          ld.Country = 'India';
        
          lstLeads.Add(ld);
        
        // Second Lead Record..
        Lead lds = new Lead();
        
          lds.FirstName = 'Shilpa';
          lds.LastName = 'Samudrala';
          lds.Title = 'Technical Lead';
          lds.Company = 'Cittacore Inc.';
          lds.Status = 'Open - Not Contacted';
          lds.Rating = 'Hot';
          lds.Industry = 'Manufacturing';
          lds.AnnualRevenue = 2500000;
          lds.Phone = '9900998877';
          lds.Fax = '7788990099';
          lds.Email = 'shilpas@cittacore.com';
          lds.LeadSource = 'Email';
          lds.City = 'Hyderabad';
          lds.State = 'Telangana';
          lds.Country = 'India';
       
          lstLeads.Add(lds);
        
        // Insert the Lead Records..
        if(! lstLeads.isEmpty())
        {
            Insert lstLeads;
            
            // Call the Method to Send the Email Notifications..
            MessagingUtility.SendEmailNotificationToLeads(lstLeads);
        }
    }
}