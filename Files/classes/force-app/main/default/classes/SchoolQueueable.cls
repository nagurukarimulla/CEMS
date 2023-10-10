Global class SchoolQueueable implements System.Queueable {
    Global void Execute(System.QueueableContext qc){
        School__c schoolRec = new School__c();
        schoolRec.Name = 'Madras University';
        schoolRec.Fees__c = 20000;
        schoolRec.School_Address__c = 'Chennai';
        schoolRec.School_Email__c = 'madrasuniversity@gmail.com';
   insert schoolRec;
    if(schoolRec.Id != null){
        System.debug('School record id:---'+ schoolRec.Id);
        Id stuJobId=System.enqueueJob(new StudentQueueable(schoolRec));
    }
}
}


/*
AsyncApexJob jobDetails = [Select Id, status, totaljobitems, jobitemsprocessed,
                           numberoferrors, Createdby.email from AsyncApexJob
                          where id=:schoolJobId];

System.debug('Job Id is:---'+ jobDetails.Id);

System.debug('Job Status is:---'+ jobDetails.status);
*/