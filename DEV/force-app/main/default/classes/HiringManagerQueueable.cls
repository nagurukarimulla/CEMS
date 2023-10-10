Global class HiringManagerQueueable implements System.Queueable
{
	Global void Execute(System.QueueableContext qContext)
    {
        // Write the Business Logic to Insert the Hiring Manager Record..
        	Hiring_Manager__C hrRecord = new Hiring_Manager__C();
        		hrRecord.Name = 'Alexa';
        		hrRecord.Location__c = 'Canada';
        		hrRecord.Contact_Number__c = '8899554433';
        		hrRecord.Email_ID__c = 'alexa@gmail.com';
        
        	insert hrRecord;
        	if(hrRecord.Id != null)
            {
                system.debug('Hiring Manager Record ID is...: '+ hrRecord.id);
                
                // Invoke the PositionQueueable class to Create the Related Position Record.
                ID posJobId = System.enqueueJob(new PositionsQueueable(hrRecord));
                
            }        		
    }
}