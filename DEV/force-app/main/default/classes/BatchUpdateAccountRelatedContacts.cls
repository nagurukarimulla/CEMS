global class BatchUpdateAccountRelatedContacts implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {

global Database.QueryLocator start(Database.BatchableContext bc) {
    String query = 'Select FirstName, LastName, Email, Status__c from Contact WHERE FirstName != null AND LastName != null AND AccountId != null';
// collect the batches of records or objects to be passed to execute
//Note: Calling Queueable job for calling the next batchfor chaining.
System.enqueueJob(new ExecuteBatchQueueableJob());
return Database.getQueryLocator(query);
}
global void execute(Database.BatchableContext bc, List<Contact> records){
// process each batch of records
for(Contact con : records){
con.Department = 'Salesforce';
}
update records;
}
global void finish(Database.BatchableContext bc){
// execute any post-processing operations
}
}