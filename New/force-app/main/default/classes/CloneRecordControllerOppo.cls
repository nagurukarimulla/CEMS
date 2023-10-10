public class CloneRecordControllerOppo {
@AuraEnabled
    public static List <Opportunity> fetchOpportunities() {
        //Qyery oppos
        List<Opportunity> oppoList = [SELECT Id, Name, LeadSource, StageName, Description from Opportunity];
        //return list of accounts
        return oppoList;
    }
    
    /*
    @AuraEnabled
   public static List<ListView> getListViews() {
    List<ListView> listviews =[SELECT Id, Name FROM ListView WHERE SobjectType = 'Opportunity'];

    // Perform isAccessible() check here
    return listviews;
}
  */ 
}