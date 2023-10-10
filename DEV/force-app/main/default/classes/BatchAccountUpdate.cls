global class BatchAccountUpdate implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {
String query = 'Select Id, Name from Account WHERE Name != null AND (Name = \'TestingAccount\' OR Name = \'Testing\') ';
global Database.QueryLocator start(Database.BatchableContext bc) {
// collect the batches of records or objects to be passed to execute
return Database.getQueryLocator(query);
}

global void execute(Database.BatchableContext bc, List<Account> records){
// process each batch of records
for(Account acc : records){
acc.Name = acc.Name + ' - Updated';
}
update records;
}

global void finish(Database.BatchableContext bc){
// execute any post-processing operations
//Note: We are calling Batch from Finish Method of Second batch.
BatchUpdateAccountRelatedContacts b = new BatchUpdateAccountRelatedContacts();
Database.executeBatch(b, 9);
}
}