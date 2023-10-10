public with sharing class CaseClosedBatchClass implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext jobId){

        String caseQuery = 'SELECT Id , Status , ContactEmail, CreatedDate FROM Case where CreatedDate<LAST_N_DAYS:5 and Status!=\'Closed\' ';

        return Database.getQueryLocator(caseQuery);
    }
    
 public Void execute(Database.BatchableContext jobId, List<Case> recordList){

        for(Case case:recordList){

            case.Status='Closed';
       
        }

      update recordList;

    }
   
    public Void finish(Database.BatchableContext jobId){

        system.debug('JOB FINISHED ');
         AsyncApexJob jobDetails = [Select id,status,totalJobItems,jobItemsProcessed,
                                 NumberofErrors, CreatedBy.Email from AsyncApexJob 
                                 Where id =: jobId.getJobId()];
        //code to send emial notification
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddress = new string[]{jobDetails.CreatedBy.Email, 'naguruk@cittacore.com'};
        email.setToAddresses(toAddress);
        email.setReplyTo('support@cittacore.com');
        email.setSenderDisplayName('CittaCore Weekly batch Support Team');
        String emailSubject = 'Alert : CittaCore Weekly Batch Job updateAccountrecordsBatchJob: ('+ jobId.getJobId()+ ') Status Notification.';
        email.setSubject(emailSubject);

        String emailContent = 'Dear technical team, <br/><br/> '+
                               'We are pleased to inform you, that todays weekly customer update batch job has been processed. <br/><br/>'+
                               'Here are the Batch Job Details---:<br/><br/>'+
                               'batch job id is....: '+jobDetails.Id+
                               '<br/>Batch job name is...: updateAccountrecordsBatchJob '+
                               '<br/>Total number of batches available...:'+ jobDetails.totalJobItems+
                               '<br/>Number of batches processed...:'+ jobDetails.jobItemsProcessed+
                               '<br/>Number of failed batches...:'+ jobDetails.NumberofErrors+
                               '<br/><br/> Please contact CittaCore Support Team, if any queries'+
                               '<br/><br/> <i>***This is a system generated email. Please do not reply***</i>'+
                               '<br/><br/> Thank you';
                               email.setHtmlBody(emailContent);
                               Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});

    }
        

    }


    public static void runJob(){

        //CaseBatchProcess.runJob();

        CaseClosedBatchClass obj = new CaseClosedBatchClass();

        Database.executeBatch(obj,1);

    }

}
   

   


public with sharing class CaseBatchProcess implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext jobId){
        String query = 'SELECT Id , Status , ContactEmail, CreatedDate FROM Case where CreatedDate<LAST_N_DAYS:5 and Status!=\'Closed\' ';
        return Database.getQueryLocator(query); 
    }
    
    public Void finish(Database.BatchableContext jobId){
        system.debug('JOB FINISHED ');
        
        
    }

    
    public Void execute(Database.BatchableContext jobId, List<Case> recordList){
        
        List<Messaging.SingleEmailMessage> emailobjs=new List<Messaging.SingleEmailMessage>();

            for(Case cse:recordList){
            cse.Status='Closed';
            Messaging.SingleEmailMessage emailobj=new Messaging.SingleEmailMessage();
            emailobj.setToAddresses(new List<String> {cse.ContactEmail});

            emailObj.setSubject('Case Status closed'+cse.Id);

            emailObj.setPlainTextBody('Your Case is closed please send me an email to reopen.');

            emailObjs.add(emailobj);


            
        }
      update recordList;
    Messaging.sendEmail(emailobjs);



    }

    public static void runJob(){
        //CaseBatchProcess.runJob();
        CaseBatchProcess obj = new CaseBatchProcess();
        Database.executeBatch(obj,1);
    }
}

global class CreateTaskEmailExample implements Messaging.InboundEmailHandler {
 
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                         Messaging.InboundEnvelope env){
   
      // Create an InboundEmailResult object for returning the result of the 
      // Apex Email Service
      Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
    
      String myPlainText= '';
      
      // Add the email plain text into the local variable 
      myPlainText = email.plainTextBody;
     
      // New Task object to be created
      Task[] newTask = new Task[0];
     
      // Try to look up any contacts based on the email from address
      // If there is more than one contact with the same email address,
      // an exception will be thrown and the catch statement will be called.
      try {
        Contact vCon = [SELECT Id, Name, Email
          FROM Contact
          WHERE Email = :email.fromAddress
          LIMIT 1];
        
        // Add a new Task to the contact record we just found above.
        newTask.add(new Task(Description =  myPlainText,
             Priority = 'Normal',
             Status = 'Inbound Email',
             Subject = email.subject,
             IsReminderSet = true,
             ReminderDateTime = System.now()+1,
             WhoId =  vCon.Id));
       
       // Insert the new Task 
       insert newTask;    
       
       System.debug('New Task Object: ' + newTask );   
      }
      // If an exception occurs when the query accesses 
      // the contact record, a QueryException is called.
      // The exception is written to the Apex debug log.
     catch (QueryException e) {
         System.debug('Query Issue: ' + e);
     }
     
     // Set the result to true. No need to send an email back to the user 
     // with an error message
     result.success = true;
     
     // Return the result for the Apex Email Service
     return result;
    }
  }