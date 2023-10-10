Global class CalculateLeadsTotalRevenue implements Database.Batchable<SObject>,Database.Stateful {
   Global Decimal totalLeadsRevenue = 0.0;
    Global Database.QueryLocator Start(Database.BatchableContext bc){
        String leadsQuery = 'Select id, firstname, lastname, annualrevenue from lead where annualrevenue!=null';
        return Database.getQueryLocator(leadsQuery);
    }
    Global void Execute(Database.BatchableContext bc, List<SObject> leadsToProcess){
        if(!leadsToprocess.isEmpty()){
            for(SObject sobj :leadsToprocess){
                Lead lrec = (Lead) sobj;
                totalLeadsRevenue += lrec.AnnualRevenue;
            }
        }
    }
    Global void finish(Database.BatchableContext bcontext){
      System.debug('Total leads Annual Revenue is:'+totalLeadsRevenue);
}
}