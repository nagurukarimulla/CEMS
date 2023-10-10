// server side code for sending bulk emails to selected records
public with sharing class InterviewEmailController {
    
    //fetching the interview scheduler records from salesforce database
       @AuraEnabled
       public static List<EMS_Interview_Scheduling__c> getInterviewRecords() {
           List<EMS_Interview_Scheduling__c> interviewList = new List<EMS_Interview_Scheduling__c>();
           try {
               interviewList = [SELECT Id, 
               EMS_Interview_Round__c, 
               EMS_Interview_Status__c, 
               EMS_Interview_Type__c, 
               EMS_Meeting_Link__c, 
               EMS_Interviewer_Name__c, 
               EMS_Job_Application_ID__c, 
               EMS_Candidate_Name__c, 
               EMS_Interview_Location__c, 
               EMS_Interview_Panel_Members__r.Name,
               EMS_Interview_Panel_Members__r.EMS_Interviewer_1__r.EMS_Work_Email__c,
               EMS_Interview_Panel_Members__r.EMS_Interviewer_2__r.EMS_Work_Email__c,
               EMS_Interview_Panel_Members__r.EMS_Interviewer_3__r.EMS_Work_Email__c,
               EMS_Applicant_Email__c, 
               EMS_Interview_Stage__c, 
               EMS_Decline_Reason__c, 
               EMS_Interview_Start_Time_c__c, 
               EMS_InterviewEndTime__c 
            FROM EMS_Interview_Scheduling__c  WITH SECURITY_ENFORCED];
           } catch(Exception e) {
               System.debug('Error fetching interview records: ' + e.getMessage());
           }
           System.debug(interviewList);
           return interviewList;
           
       }
   
       @AuraEnabled
       public static void sendBulkEmails(List<Id> interviewIds) {
           List<EMS_Interview_Scheduling__c> interviewList = new List<EMS_Interview_Scheduling__c>();
           try {
               interviewList = [SELECT Id, 
               EMS_Interview_Start_Time_c__c, 
               EMS_Interview_Round__c, 
               EMS_InterviewEndTime__c, 
               EMS_Interview_Status__c, 
               EMS_Interview_Type__c, 
               EMS_Meeting_Link__c, 
               EMS_Interviewer_Name__c, 
               EMS_Job_Application_ID__c, 
               EMS_Candidate_Name__c, 
               EMS_Interview_Location__c, 
               EMS_Applicant_Email__c,
               EMS_Interview_Panel_Members__r.Name,
               EMS_Interview_Panel_Members__r.EMS_Interviewer_1__r.EMS_Work_Email__c,
               EMS_Interview_Panel_Members__r.EMS_Interviewer_2__r.EMS_Work_Email__c,
               EMS_Interview_Panel_Members__r.EMS_Interviewer_3__r.EMS_Work_Email__c,
               EMS_Interview_Stage__c, EMS_Decline_Reason__c FROM EMS_Interview_Scheduling__c WHERE EMS_Interview_Status__c = 'Accepted' AND Id IN :interviewIds WITH SECURITY_ENFORCED];
           } catch(Exception e) {
               System.debug('Error fetching interview records: ' + e.getMessage());
           }
           List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
           Integer emailCount = 0;
           for(EMS_Interview_Scheduling__c interview : interviewList) {
               try {
                   Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                   String[] toAddresses = new String[] { };
                   if(interview.EMS_Interview_Type__c == 'Virtual Interview' || interview.EMS_Interview_Type__c == 'In Person Interview') {
                       toAddresses = new String[] { interview.EMS_Applicant_Email__c, interview.EMS_Interview_Panel_Members__r.EMS_Interviewer_1__r.EMS_Work_Email__c, interview.EMS_Interview_Panel_Members__r.EMS_Interviewer_2__r.EMS_Work_Email__c, interview.EMS_Interview_Panel_Members__r.EMS_Interviewer_3__r.EMS_Work_Email__c};
                       System.debug(toAddresses);
                   }
                   email.setToAddresses(toAddresses);
                   email.setSubject('Interview Schedule Details');
                   String body = '';
                   DateTime startDateTime = DateTime.newInstance(interview.EMS_Interview_Start_Time_c__c.year(), interview.EMS_Interview_Start_Time_c__c.month(), interview.EMS_Interview_Start_Time_c__c.day(), interview.EMS_Interview_Start_Time_c__c.hour(), interview.EMS_Interview_Start_Time_c__c.minute(), 0);
                   DateTime endDateTime = DateTime.newInstance(interview.EMS_InterviewEndTime__c.year(), interview.EMS_InterviewEndTime__c.month(), interview.EMS_InterviewEndTime__c.day(), interview.EMS_InterviewEndTime__c.hour(), interview.EMS_InterviewEndTime__c.minute(), 0);
                   body = 'Good day,\n\n';
                   body += 'We would like to remind you that an upcoming interview has been scheduled as follows:\n\n';
                   body += 'Your interview is scheduled for ' + startDateTime.format('MM/dd/yyyy hh:mm a') + ' - ' + endDateTime.format('hh:mm a') + ' (UTC).\n';
                   if(interview.EMS_Interview_Type__c == 'Virtual Interview') {
                       body += 'The interview will be held virtually. Please use the following link to join the virtual interview: ' + interview.EMS_Meeting_Link__c + '\n\n';
                       body += 'Thank you and best regards,\nHR Team';
                   } else if(interview.EMS_Interview_Type__c == 'In Person Interview') {
                       body += 'The interview will be held in-person at the following location: ' + interview.EMS_Interview_Location__c + '\n\n';
                       body += 'Thank you and best regards,\nHR Team';
                   }
                   email.setPlainTextBody(body);
                   emails.add(email);
                   emailCount++;
               } catch(Exception e) {
                   System.debug('Error creating email: ' + e.getMessage());
               }
           }
           try {
               if(!emails.isEmpty()) {
                   System.debug('Sending emails...');
                   Messaging.sendEmail(emails);
                   System.debug(emailCount + ' emails sent.');
               }
           } catch(Exception e) {
               System.debug('Error sending emails: ' + e.getMessage());
           }
       }
    }










/*
// server side code for sending bulk emails to selected records
public with sharing class InterviewEmailController {
    
 //fetching the interview scheduler records from salesforce database
    @AuraEnabled
    public static List<EMS_Interview_Scheduling__c> getInterviewRecords() {
        List<EMS_Interview_Scheduling__c> interviewList = new List<EMS_Interview_Scheduling__c>();
        try {
            interviewList = [SELECT Id, EMS_Interview_Round__c, EMS_Interview_Status__c, EMS_Interview_Type__c, EMS_Meeting_Link__c, EMS_Interviewer_Name__c, EMS_Job_Application_ID__c, EMS_Candidate_Name__c, EMS_Interview_Location__c, EMS_Interviewer_Email__c, EMS_Applicant_Email__c, EMS_Interviewer_2_Email__c, EMS_Interview_Stage__c, EMS_Decline_Reason__c, EMS_Interview_Start_Time_c__c, EMS_InterviewEndTime__c FROM EMS_Interview_Scheduling__c WITH SECURITY_ENFORCED];
        } catch(Exception e) {
            System.debug('Error fetching interview records: ' + e.getMessage());
        }
        return interviewList;
    }

    @AuraEnabled
    public static void sendBulkEmails(List<Id> interviewIds) {
        List<EMS_Interview_Scheduling__c> interviewList = new List<EMS_Interview_Scheduling__c>();
        try {
            interviewList = [SELECT Id, EMS_Interview_Start_Time_c__c, EMS_Interview_Round__c, EMS_InterviewEndTime__c, EMS_Interview_Status__c, EMS_Interview_Type__c, EMS_Meeting_Link__c, EMS_Interviewer_Name__c, EMS_Job_Application_ID__c, EMS_Candidate_Name__c, EMS_Interview_Location__c, EMS_Interviewer_Email__c, EMS_Applicant_Email__c, EMS_Interviewer_2_Email__c, EMS_Interview_Stage__c, EMS_Decline_Reason__c FROM EMS_Interview_Scheduling__c WHERE EMS_Interview_Status__c = 'Accepted' AND Id IN :interviewIds WITH SECURITY_ENFORCED];
        } catch(Exception e) {
            System.debug('Error fetching interview records: ' + e.getMessage());
        }
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(EMS_Interview_Scheduling__c interview : interviewList) {
            try {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] { };
                if(interview.EMS_Interview_Type__c == 'Virtual Interview' || interview.EMS_Interview_Type__c == 'In Person Interview') {
                    toAddresses = new String[] { interview.EMS_Applicant_Email__c, interview.EMS_Interviewer_Email__c, interview.EMS_Interviewer_2_Email__c };
                }
                email.setToAddresses(toAddresses);
                email.setSubject('Interview Schedule Details');
                String body = '';
                DateTime startDateTime = DateTime.newInstance(interview.EMS_Interview_Start_Time_c__c.year(), interview.EMS_Interview_Start_Time_c__c.month(), interview.EMS_Interview_Start_Time_c__c.day(), interview.EMS_Interview_Start_Time_c__c.hour(), interview.EMS_Interview_Start_Time_c__c.minute(), 0);
                DateTime endDateTime = DateTime.newInstance(interview.EMS_InterviewEndTime__c.year(), interview.EMS_InterviewEndTime__c.month(), interview.EMS_InterviewEndTime__c.day(), interview.EMS_InterviewEndTime__c.hour(), interview.EMS_InterviewEndTime__c.minute(), 0);
                body += 'Your interview is scheduled for ' + startDateTime.format('MM/dd/yyyy hh:mm a') + ' - ' + endDateTime.format('hh:mm a') + ' (UTC).\n';
                if(interview.EMS_Interview_Type__c == 'Virtual Interview') {
                    body += 'The interview will be held virtually. Please use the following link to join the virtual interview: ' + interview.EMS_Meeting_Link__c + '\n';
                } else if(interview.EMS_Interview_Type__c == 'In Person Interview') {
                    body += 'The interview will be held in-person at the following location: ' + interview.EMS_Interview_Location__c + '\n';
                }
                email.setPlainTextBody(body);
                emails.add(email);
            } catch(Exception e) {
                System.debug('Error creating email: ' + e.getMessage());
            }
        }
        try {
            if(!emails.isEmpty()) {
                System.debug('Sending emails...');
                Messaging.sendEmail(emails);
            }
        } catch(Exception e) {
            System.debug('Error sending emails: ' + e.getMessage());
        }
    }
}
*/
/*
public with sharing class InterviewEmailController {

    @AuraEnabled
    public static List<EMS_Interview_Scheduling__c> getInterviewRecords() {
        List<EMS_Interview_Scheduling__c> interviewList = new List<EMS_Interview_Scheduling__c>();
        try {
            interviewList = [SELECT Id, EMS_Interview_Round__c, EMS_Interview_Status__c, EMS_Interview_Type__c, EMS_Meeting_Link__c, EMS_Interviewer_Name__c, EMS_Job_Application_ID__c, EMS_Candidate_Name__c, EMS_Interview_Location__c, EMS_Interviewer_Email__c, EMS_Applicant_Email__c, EMS_Interviewer_2_Email__c, EMS_Interview_Stage__c, EMS_Decline_Reason__c, EMS_Interview_Start_Time_c__c, EMS_InterviewEndTime__c FROM EMS_Interview_Scheduling__c WITH SECURITY_ENFORCED];
        } catch(Exception e) {
            System.debug('Error fetching interview records: ' + e.getMessage());
        }
        return interviewList;
    }

    @AuraEnabled
    public static void sendBulkEmails(List<Id> interviewIds) {
        List<EMS_Interview_Scheduling__c> interviewList = new List<EMS_Interview_Scheduling__c>();
        try {
            interviewList = [SELECT Id, EMS_Interview_Start_Time_c__c, EMS_Interview_Round__c, EMS_InterviewEndTime__c, EMS_Interview_Status__c, EMS_Interview_Type__c, EMS_Meeting_Link__c, EMS_Interviewer_Name__c, EMS_Job_Application_ID__c, EMS_Candidate_Name__c, EMS_Interview_Location__c, EMS_Interviewer_Email__c, EMS_Applicant_Email__c, EMS_Interviewer_2_Email__c, EMS_Interview_Stage__c, EMS_Decline_Reason__c FROM EMS_Interview_Scheduling__c WHERE EMS_Interview_Status__c = 'Accepted' AND Id IN :interviewIds WITH SECURITY_ENFORCED];
        } catch(Exception e) {
            System.debug('Error fetching interview records: ' + e.getMessage());
        }
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(EMS_Interview_Scheduling__c interview : interviewList) {
            try {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] { };
                if(interview.EMS_Interview_Type__c == 'Virtual Interview') {
                    toAddresses = new String[] { interview.EMS_Applicant_Email__c, interview.EMS_Interviewer_Email__c, interview.EMS_Interviewer_2_Email__c };
                } else if(interview.EMS_Interview_Type__c == 'In Person Interview') {
                    toAddresses = new String[] { interview.EMS_Applicant_Email__c, interview.EMS_Interviewer_Email__c, interview.EMS_Interviewer_2_Email__c };
                }
                email.setToAddresses(toAddresses);
                email.setSubject('Interview Schedule Details');
                String body = '';
                DateTime startDateTime = DateTime.newInstance(interview.EMS_Interview_Start_Time_c__c.year(), interview.EMS_Interview_Start_Time_c__c.month(), interview.EMS_Interview_Start_Time_c__c.day(), interview.EMS_Interview_Start_Time_c__c.hour(), interview.EMS_Interview_Start_Time_c__c.minute(), 0);
                DateTime endDateTime = DateTime.newInstance(interview.EMS_InterviewEndTime__c.year(), interview.EMS_InterviewEndTime__c.month(), interview.EMS_InterviewEndTime__c.day(), interview.EMS_InterviewEndTime__c.hour(), interview.EMS_InterviewEndTime__c.minute(), 0);
                body += 'Your interview is scheduled for ' + startDateTime.format('MM/dd/yyyy hh:mm a') + ' - ' + endDateTime.format('hh:mm a') + ' (UTC).\n';
                if(interview.EMS_Interview_Type__c == 'Virtual Interview') {
                    body += 'The interview will be held virtually. Please use the following link to join the virtual interview: ' + interview.EMS_Meeting_Link__c + '\n';
                } else if(interview.EMS_Interview_Type__c == 'In Person Interview') {
                    body += 'The interview will be held in-person at the following location: ' + interview.EMS_Interview_Location__c + '\n';
                }
                email.setPlainTextBody(body);
                emails.add(email);
            } catch(Exception e) {
                System.debug('Error creating email: ' + e.getMessage());
            }
        }
        try {
            if(!emails.isEmpty()) {
                System.debug('Sending emails...');
                Messaging.sendEmail(emails);
            }
        } catch(Exception e) {
            System.debug('Error sending emails: ' + e.getMessage());
        }
    }
}
*/
/*
// server side code for sending bulk emails to selected records
public with sharing class InterviewEmailController {

    //fetching the interview scheduler records from salesforce database
@AuraEnabled
public static List<EMS_Interview_Scheduling__c> getInterviewRecords() {
    List<EMS_Interview_Scheduling__c> interviewList = [SELECT Id,  
                                                      EMS_Interview_Round__c,  
                                                      EMS_Interview_Status__c, EMS_Interview_Type__c, 
                                                      EMS_Meeting_Link__c, EMS_Interviewer_Name__c, 
                                                      EMS_Job_Application_ID__c, EMS_Candidate_Name__c, 
                                                      EMS_Interview_Location__c, EMS_Interviewer_Email__c, 
                                                      EMS_Applicant_Email__c, EMS_Interviewer_2_Email__c, EMS_Interview_Stage__c, 
                                                      EMS_Decline_Reason__c, EMS_Interview_Start_Time_c__c, EMS_InterviewEndTime__c
                                                      FROM EMS_Interview_Scheduling__c];
    return interviewList;
}

@AuraEnabled
public static void sendBulkEmails(List<Id> interviewIds) {
List<EMS_Interview_Scheduling__c> interviewList = [SELECT Id, EMS_Interview_Start_Time_c__c, EMS_Interview_Round__c, EMS_InterviewEndTime__c, EMS_Interview_Status__c, EMS_Interview_Type__c, EMS_Meeting_Link__c, EMS_Interviewer_Name__c, EMS_Job_Application_ID__c, EMS_Candidate_Name__c, EMS_Interview_Location__c, EMS_Interviewer_Email__c, EMS_Applicant_Email__c, EMS_Interviewer_2_Email__c, EMS_Interview_Stage__c, EMS_Decline_Reason__c FROM EMS_Interview_Scheduling__c WHERE EMS_Interview_Status__c = 'Accepted' AND Id IN :interviewIds];
List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
for(EMS_Interview_Scheduling__c interview : interviewList) {
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    String[] toAddresses = new String[] { };
    
    //condition checking for interview type virtual and in person and setting toaddress
    if(interview.EMS_Interview_Type__c == 'Virtual Interview') {
        toAddresses = new String[] { interview.EMS_Applicant_Email__c, interview.EMS_Interviewer_Email__c, interview.EMS_Interviewer_2_Email__c };
    } else if(interview.EMS_Interview_Type__c == 'In Person Interview') {
        toAddresses = new String[] { interview.EMS_Applicant_Email__c, interview.EMS_Interviewer_Email__c, interview.EMS_Interviewer_2_Email__c };
    }
    
    email.setToAddresses(toAddresses);
    email.setSubject('Interview Schedule Details');
    String body = '';
    
    // Add both in-person and virtual interview details to the email body
    DateTime startDateTime = DateTime.newInstance(interview.EMS_Interview_Start_Time_c__c.year(), interview.EMS_Interview_Start_Time_c__c.month(), interview.EMS_Interview_Start_Time_c__c.day(), interview.EMS_Interview_Start_Time_c__c.hour(), interview.EMS_Interview_Start_Time_c__c.minute(), 0);
    DateTime endDateTime = DateTime.newInstance(interview.EMS_InterviewEndTime__c.year(), interview.EMS_InterviewEndTime__c.month(), interview.EMS_InterviewEndTime__c.day(), interview.EMS_InterviewEndTime__c.hour(), interview.EMS_InterviewEndTime__c.minute(), 0);
    body += 'Your interview is scheduled for ' + startDateTime.format('MM/dd/yyyy hh:mm a') + ' - ' + endDateTime.format('hh:mm a') + ' (UTC).\n';
    
    if(interview.EMS_Interview_Type__c == 'Virtual Interview') {
        body += 'The interview will be held virtually. Please use the following link to join the virtual interview: ' + interview.EMS_Meeting_Link__c + '\n';
    } else if(interview.EMS_Interview_Type__c == 'In Person Interview') {
        body += 'The interview will be held in-person at the following location: ' + interview.EMS_Interview_Location__c + '\n';
    }
    
    email.setPlainTextBody(body);
    emails.add(email);
}

// check if emails list is not empty before calling Messaging.sendEmail()
System.debug('Number of emails in the list: ' + emails.size());
if(!emails.isEmpty()) {
    System.debug('Sending emails...');
    Messaging.sendEmail(emails);
}
System.debug('Email sending completed');

}
}             
  */


                    
                    
                    























