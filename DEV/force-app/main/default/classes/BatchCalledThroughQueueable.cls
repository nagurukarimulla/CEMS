global class BatchCalledThroughQueueable implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {
String query = 'Select FirstName, LastName, Email, Status, Title from Lead WHERE FirstName != null AND LastName != null';
global Database.QueryLocator start(Database.BatchableContext bc) {
// collect the batches of records or objects to be passed to execute
return Database.getQueryLocator(query);
}
global void execute(Database.BatchableContext bc, List<Lead> records){
// process each batch of records
for(Lead ld : records){
ld.Title = ld.FirstName + ' - ' + ld.LastName;
}
update records;
}
global void finish(Database.BatchableContext bc){
// execute any post-processing operations
}
}