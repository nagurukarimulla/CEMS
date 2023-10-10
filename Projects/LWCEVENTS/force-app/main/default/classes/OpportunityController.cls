public with sharing class OpportunityController {
    @AuraEnabled
    public static List<Opportunity> fetchOpportunities(){
        return [SELECT Id, Name, AccountId, TotalOpportunityQuantity, Amount, StageName FROM Opportunity LIMIT 4];
    }
}