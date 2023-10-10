public with sharing class CaseBatchProcess implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext jobId){
        String query = 'SELECT Id , Status , ContactEmail, CreatedDate FROM Case where CreatedDate<LAST_N_DAYS:4 and Status!=\'Closed\' and ContactEmail!=NULL ';
        return Database.getQueryLocator(query);
    }
     public Void execute(Database.BatchableContext jobId,List<Case> recordList){
    for(Case cse:recordList){
            cse.Status='Closed';
    }
        update recordList;
    }
    public Void finish(Database.BatchableContext jobId){
        
        List<Case> recordList =[SELECT Id , Status , ContactEmail, CreatedDate FROM Case where CreatedDate<LAST_N_DAYS:4 and Status!='Closed' and ContactEmail!=NULL];
            List<Messaging.SingleEmailMessage> emailobjs=new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage emailobj=new Messaging.SingleEmailMessage();



           for(Case cas:recordList){
            
            emailobj.setToAddresses(new List<String> {cas.ContactEmail});
            //emailobj.setTargetObjectId(cas.ContactId);
            emailObj.setSubject('Case Status closed'+cas.Id);
           	emailObj.setPlainTextBody('Your Case is closed please send me an email to reopen.');
            emailObj.setReplyTo('caseinboundservice@trvf51xca0sp4xjnuldq41xg62lk3th6ryxkloqaltolfu18k.5i-2q4gaeak.ap26.apex.salesforce.com');
            emailObjs.add(emailobj);
            
        }
      
    Messaging.sendEmail(emailobjs);
        
    }



   
   



   public static void runJob(){
        //CaseBatchProcess.runJob();
        CaseBatchProcess obj = new CaseBatchProcess();
        Database.executeBatch(obj,200);
    }
}