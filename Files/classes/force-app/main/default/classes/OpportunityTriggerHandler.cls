public with sharing class OpportunityTriggerHandler extends TriggerHandler {
    // Get all you Trigger Context data Mapping 
    /*
    1) Trigger.new --> Before Insert
    2) Trigger.newMap 
    3) Trigger.oldMap
     */
    List<Opportunity> triggerNew;
    Map<Id,Opportunity> triggerNewMap;
    Map<Id,Opportunity> triggerOldMap;
    public OpportunityTriggerHandler() {
        // Parse your List<sObject> to List<Opportunity>
        triggerNew = (List<Opportunity>)Trigger.new;
        if(Trigger.newMap != null ){
            triggerNewMap = (Map<Id,Opportunity>) Trigger.newMap;
        }
        if(Trigger.oldMap != null){
            triggerOldMap = (Map<Id,Opportunity>) Trigger.oldMap;
        }
    }

    // Before Insert Logic
    public override void beforeInsert(){
        /*
        Given : A sales user is creating a new Opportunity by selecting Account
        When :  any Opportunity is open for the same Account 
        Then : Update the Previous Open Opportunity to Closed Lost and Populate Previous Opportunity Id in Newly creating Opportunity by Sales User
         */
        // Find the WHERE class Elements --> AccountId , StageName != 'Closed Lost'
        Set<Id> accountIds = new Set<Id>();
        Map<Id,AccountOpportunities> accountsOpps = new Map<Id,AccountOpportunities>();
        for(Opportunity record : triggerNew){
            // check for Account is not Null
            if(record.AccountId != null){
                accountIds.add(record.AccountId);
            }
            if(accountsOpps.get(record.AccountId) == null){
                accountsOpps.put(record.AccountId , new AccountOpportunities());
            }
            accountsOpps.get(record.AccountId).newOpportunity = record;
           
        }

        if(accountIds.size() > 0 ){
        // Extract the Exiting Open Opportunities based on StageName and AccountIds 
        List<Opportunity> exitingOpportunities = [SELECT Id , Name , StageName , AccountId FROM Opportunity WHERE StageName != 'Closed Lost' AND    AccountId IN: AccountIds];
        // Is Having exiting Opportunities 
        if(exitingOpportunities.size() > 0 ){
           for(Opportunity oldRecord : exitingOpportunities){
                accountsOpps.get(oldRecord.AccountId).OldOpportunity = oldRecord;
           } 

           // Update the Opportunities 
           for(AccountOpportunities dmlRecords : accountsOpps.values()){
                dmlRecords.OldOpportunity.StageName = 'Close Lost';
                dmlRecords.newOpportunity.Old_Opportunity__c = dmlRecords.OldOpportunity.Id;
                
           }
           update exitingOpportunities;
        }
        }
    }

    // After Event Logic 
    public override void afterInsert(){
        /*
            Given : Sales user creates a New Opportunity  having accountId
            When : New Opportunity have Old Opportunity Field or Blank
            Then : Update Related Account New Opportunity with new recordId and Old Opportunity with Old Opportunity field 
        */
        /* AccountId -->
            We need to updates ? YES
            Do we need any extra information from Account ? NO 
            Do we have all the fields to be update in Account ? YES
            Do we need to have any conditionals within Current account Details ? NO
        */
        List<Account> accList = new List<Account>();
        for(Opportunity newRecord : triggerNew){
            Account acc = new Account();
            acc.Id = newRecord.AccountId;
            acc.New_Opportunity__c = newRecord.Id;
            acc.Old_Opportunity__c = newRecord.Old_Opportunity__c;
            accList.add(acc);
        }
        TriggerHandler.bypass('AccountTriggerHandler');
        update accList;

    }
    private class AccountOpportunities{
        private Opportunity newOpportunity;
        private Opportunity OldOpportunity;
        private Id accountId;
    }

}