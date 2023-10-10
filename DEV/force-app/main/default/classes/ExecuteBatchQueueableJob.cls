global class ExecuteBatchQueueableJob implements Queueable {
public void execute(QueueableContext context) {
try{
BatchCalledThroughQueueable b = new BatchCalledThroughQueueable();
Database.executeBatch(b, 200);
}catch(Exception e){
System.debug('@@@ Error Message : '+e.getMessage());
}
}
}