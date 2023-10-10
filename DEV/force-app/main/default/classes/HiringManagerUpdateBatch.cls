Global class HiringManagerUpdateBatch implements Database.Batchable<SObject>
{
	Global Database.QueryLocator Start(Database.BatchableContext bContext)
    {
        string hrRecordsQuery = 'Select id, name, location__C, contact_number__C, email_id__C from Hiring_Manager__C';
        return Database.getQueryLocator(hrRecordsQuery);
    }
    
    Global void Execute(Database.BatchableContext bContext, List<SObject> recordsToProcess)
    {
        if(! recordsToProcess.isEmpty())
        {
            List<Hiring_Manager__C> hrRecordsToUpdate = new List<Hiring_Manager__C>();
            
            for(SObject obj : recordsToProcess)
            {
                Hiring_Manager__C hrRecord = (Hiring_Manager__C) obj;
                
                	hrRecord.Location__c = 'Chennai';
                	hrRecord.Contact_Number__c = '9090909090';
                
                hrRecordsToUpdate.Add(hrRecord);
            }
            
            if(! hrRecordsToUpdate.isEmpty())
            {
                Update hrRecordsToUpdate;
            }
        }
    }
    
    Global void Finish(Database.BatchableContext bContext)
    {
        System.debug('Batch Job Id is....: '+ bContext.getJobId());
        
        AsyncApexJob jobDetails = [Select id, status, totaljobItems, jobitemsprocessed, 
                                  			numberoferrors, createdby.email
                                  					from AsyncApexJob
                                  							Where id =: bContext.getJobId()];
        
		MessagingUtilityHelper.SendBatchJobStatusNotifications(jobDetails,'HiringManagerUpdateBatch');        
    }
}


//Execution
// Invoking the Batch Class..
//	HiringManagerUpdateBatch hrBatch = new HiringManagerUpdateBatch();

// Invoke by using Database.ExecuteBatch().
//	Database.executeBatch(hrBatch, 10);