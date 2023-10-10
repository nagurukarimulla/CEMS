public with sharing class OppController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunitiesList(){
        return [SELECT Id, Name, ExpectedRevenue, StageName, LeadSource from Opportunity LIMIT 6];
    }
    

    @AuraEnabled(cacheable=true)
    public static List<Case> getCaseList(){
        return [SELECT Id, Origin, AccountId,Priority, Type, Status from Case LIMIT 6];
    }

}