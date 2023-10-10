Global class updateAccountrecordsBatchJob implements database.Batchable<SObject> {
    Global Database.QueryLocator Start(Database.BatchableContext bcontext){
        String accountQuery = 'select id, name, rating, industry, annualrevenue, active__c from Account';
        return Database.getQueryLocator(accountQuery);
    }
    Global void Execute(Database.BatchableContext bcontext, List<SObject> recordsToprocess){
         if(!recordsToprocess.isEmpty()){
            List<Account> accountsToUpdate = new List<Account>();
            for(SObject sobj : recordsToprocess){
                Account accRecord = (Account) sobj;
                accRecord.Rating='Warm';
                accRecord.Industry='Technology';
                accRecord.AnnualRevenue=1500000;
                accRecord.Active__c='Yes';
                accountsToUpdate.add(accRecord);

            }
            if(!accountsToUpdate.isEmpty()){
                update accountsToUpdate;
            }
         }
    }
    Global void finish(Database.BatchableContext bcontext){
      AsyncApexJob jobDetails = [Select id,status,totalJobItems,jobItemsProcessed,
                                 NumberofErrors, CreatedBy.Email from AsyncApexJob 
                                 Where id =: bContext.getJobId()];
        //code to send emial notification
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddress = new string[]{jobDetails.CreatedBy.Email, 'nkarim0311@gmail.com'};
        email.setToAddresses(toAddress);
        email.setReplyTo('support@cittacore.com');
        email.setSenderDisplayName('CittaCore Weekly batch Support Team');
        String emailSubject = 'Alert : CittaCore Weekly Batch Job updateAccountrecordsBatchJob: ('+ bcontext.getJobId()+ ') Status Notification.';
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