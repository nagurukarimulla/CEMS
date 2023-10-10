trigger TestPlatfoemEventAccountTrigger on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        List<Account_platform_Event__e> pe = new List<Account_platform_Event__e>();
        for(Account a:Trigger.new){
          Account_platform_Event__e e = new Account_platform_Event__e();
            e.Account_Name__c = a.Name;
            e.Phone__c = a.Phone;
            e.Salary__c = String.valueOf(a.AnnualRevenue);
            pe.add(e);
        }
        if(pe.size()>0){
            EventBus.publish(pe);
        }
    }
}