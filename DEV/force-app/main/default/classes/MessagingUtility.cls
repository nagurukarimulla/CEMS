public class MessagingUtility 
{
  Public static void SendEmailNotificationToLeads(List<Lead> leadRecords)
    {
        if(! leadRecords.isEmpty())  
        {            
            // Create a List Collection.To Store multiple Lead Record's Email Notification Details..
            List<Messaging.SingleEmailMessage> lstEmails = new List<Messaging.SingleEmailMessage>();
                        
            for(Lead ld : leadRecords)
            {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                
                  string[] toAddress = new string[]{ld.Email, 'naguruk@cittacore.com'};
                    email.setToAddresses(toAddress);
                
                  string[] ccAddress = new string[]{ld.Email, 'nalinirajus@cittacore.com'};
                    //email.setCcAddresses(ccAddress);
                
                  string[] bccAddress = new string[]{ld.Email, 'arpita@cittacore.com'};
                    //email.setBccAddresses(bccAddress);
                    
                    email.setReplyTo('customersupport@icici.com');
                  
                  email.setSenderDisplayName('ICICI Bank Credit Card Department.');
                
                  string emailSubject = 'Congratulations '+ ld.FirstName + ' '+ ld.LastName + ' ..!! Your Credit Card Application has been received Successfully.';
                  email.setSubject(emailSubject);
                
                  string emailContent = 'Dear  '+ ld.FirstName + ' '+ ld.LastName+ ', <br/><br/>'+
                              'Thanks for showing your interest in our Organization. And we are pleased to inform you your Credit Card Application has been received Successfully. <br/><br/>'+
                              'Here are your Application Details...: <br/><br/>'+
                              'Application ID ....: '+ ld.Id + 
                              '<br/> Applicant Name : '+ ld.FirstName + ' '+ ld.LastName+
                              '<br/> Applicant Designation ....: '+ ld.Title + 
                              '<br/> Company Name .....: '+ ld.Company + 
                              '<br/> Application Status .....: '+ ld.Status +
                              '<br/> Contact Number .......: '+ ld.Phone +
                              '<br/> Fax Number .........: '+ ld.Fax +
                              '<br/> Applicant Email Id .....: '+ ld.Email+
                              '<br/> Applicant Rating ........: '+ ld.Rating +
                              '<br/> Industry Name .........: '+ ld.Industry+
                              '<br/> Annual Revenue is.........: '+ ld.AnnualRevenue +
                              '<br/> Lead Source ............: '+ ld.LeadSource+
                              '<br/> Applicant City ..........: '+ ld.City+
                              '<br/> Applicant State Name ......: '+ ld.State+
                              '<br/> Country Name .............: '+ ld.Country+
                              '<br/><br/> One of our Sales Person will contact you Shortly. Please contact on the below address, if any queries.<br/><br/>'+
                              'Thanks & Regards, <br/> ICICI Bank Credit Card Department, <br/> Hyderabad.';
                
                  email.setHtmlBody(emailContent);
                
                  // Preparing Attachment...
                  Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                    attach.setContentType('Application/pdf');
                    attach.setFileName(ld.FirstName+' '+ld.LastName+'.pdf');
                    attach.body = Blob.toPdf(emailContent);
                
                  //Prepare a List Collection to Store all the Attachments..  
                  List<Messaging.EmailFileAttachment> lstAttachments = new List<Messaging.EmailFileAttachment>();
                  
                  // Add the Attachment to List Collection..
                  lstAttachments.Add(attach);
                
                  // Add the Attachments to Email..
                  email.setFileAttachments(lstAttachments);
                
                // Add the Lead Email Alert to Collection..
                  lstEmails.Add(email);
            }
            
            if(! lstEmails.isEmpty())
            {
                Messaging.SendEmailResult[] results = Messaging.sendEmail(lstEmails);
            }
        }
    }
}