trigger OpportunityChangeEventTrigger on OpportunityChangeEvent (after insert) {
    System.debug('CDC'+String.ValueOf(Trigger.New[0]));
    //String k = String.valueOf('OPPORTUNITY-NALIN');
    List<Opportunity> updateList =new List<Opportunity>();
    for(OpportunityChangeEvent cdcOpp : trigger.new){
        Eventbus.ChangeEventHeader header = cdcOpp.ChangeEventHeader;
        //Find the type of actions performed by the user
        String courseOfAction=header.getChangeType();
        if(courseOfAction=='UPDATE'){
            List<String> oppId=header.RecordIds;
            List<String> fields=header.changedFields;
            for(String recId:oppId){
                Opportunity op=new Opportunity();
                op.Id=Id.valueOf(recId);
                for(String field:fields){
                    if(field=='Name' ){
                        op.Description=cdcOpp.Name;
                        updateList.add(op);
                    }
                }
            }
            UPDATE updateList;
        }
    }
}