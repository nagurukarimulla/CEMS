public with sharing class CaseClosedBatchClass implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext jobId){

        String caseQuery = 'SELECT Id , Status , ContactEmail, CreatedDate FROM Case where CreatedDate<LAST_N_DAYS:5 and Status!=\'Closed\' ';

        return Database.getQueryLocator(caseQuery);
    }
    
 public Void execute(Database.BatchableContext jobId, List<Case> recordList){

        for(Case c:recordList){

            c.Status='Closed';
       
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
                               'We are pleased to inform you, Your Case is closed please send me an email to reopen. <br/><br/>'+
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