Global class PurgeClosedPositionsBatchJob implements Database.Batchable<SObject>
{
	Global Database.QueryLocator Start(Database.BatchableContext bContext)
    {
        string positionsQuery = 'Select id, name, Position_Record_Can_Delete__c from Position__C where Position_Record_Can_Delete__c = true';
        return Database.getQueryLocator(positionsQuery);
    }
    
    Global void Execute(Database.BatchableContext bContext, List<SObject> recordsToProcess)
    {
        if(! recordsToProcess.isEmpty())
        {
            List<Position__C> positionsToDelete = (List<Position__C>) recordsToProcess;
            
           	Database.DeleteResult[] results = Database.delete(positionsToDelete,false);
        }
    }
    
    Global void Finish(Database.BatchableContext bContext)
    {
        System.debug('Batch Job ID is....: '+ bContext.getJobId()); 
        
        AsyncApexJob jobDetails = [Select id, status, totaljobitems, jobitemsprocessed, numberoferrors,
                                  		Createdby.email
                                  				from AsyncApexJOb
                                  						Where id =: bContext.getJobId()];
        
        System.debug('Batch Job Status....: '+ jobDetails.Status);
        
    }
}