Global class CalculateTotalAnnualRevenueBatch implements Database.Batchable<SObject>, Database.Stateful
{
    Global Decimal totalAnnualRevenue = 0.0;
    
	Global Database.QueryLocator Start(Database.BatchableContext bContext)
    {
        string accountsQuery = 'Select id, name, annualrevenue from Account where annualrevenue != null';
        return Database.getQueryLocator(accountsQuery);
    }
    
    Global void Execute(Database.BatchableContext bContext, List<Sobject> accountsToProcess)
    {
        if(! accountsToProcess.isEmpty())
        {
            for(SObject obj : accountsToProcess)
            {
                Account acc = (Account) obj;
                
                totalAnnualRevenue += acc.AnnualRevenue;
            }
        }
    }
    
    Global void Finish(Database.BatchableContext bContext)
    {
        system.debug('Batch Job Id is.....: '+ bContext.getJobId());
        
		AsyncApexJob jobDetails = [Select id, status, totaljobItems, jobItemsProcessed, 
                                  			NumberOfErrors, CreatedBy.Email
                                  				from AsyncApexJob
                                  						Where id =: bContext.getJobId() ];        
        
        MessagingUtilityHelper.SendTotalRevenueJobStatusNotification(jobDetails, 'CalculateTotalAnnualRevenueBatch', totalAnnualRevenue);
    }
}





//Execution
//CalculateTotalAnnualRevenueBatch revenueBatch = new CalculateTotalAnnualRevenueBatch();
//Database.executeBatch(revenueBatch, 4);