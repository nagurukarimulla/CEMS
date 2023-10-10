Global class PurgeClosedPositionsScheduleJob implements System.Schedulable
{
	Global void Execute(System.SchedulableContext sContext)
    {
        // Write the Code to invoke the Batch Class..
        PurgeClosedPositionsBatchJob pBatch= new PurgeClosedPositionsBatchJob();
         Database.executeBatch(pBatch, 5);
       
    }
}