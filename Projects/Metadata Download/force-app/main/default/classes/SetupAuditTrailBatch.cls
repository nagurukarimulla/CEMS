global class SetupAuditTrailBatch implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Action, CreatedBy.Name, CreatedDate, Display, Section FROM SetupAuditTrail where CreatedDate= Today';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<SetupAuditTrail> records) {
        system.debug('hello');
        
        List<CaptutrAuditTrails__c> catList = new List<CaptutrAuditTrails__c>();
        // Process the retrieved audit history records here
        for (SetupAuditTrail record : (List<setupAuditTrail>)records) {
            CaptutrAuditTrails__c ca= new CaptutrAuditTrails__c();
            
            ca.Action__c= record.Action;
            ca.CreatedByName__c=record.CreatedBy.Name;
            ca.CreatedDate__c=record.CreatedDate;
            ca.Display__c=record.Display;
            ca.Section__c=record.Section;
            ca.Name=record.CreatedBy.Name;
           
                catList.add(ca);
            //System.debug('Audit trail record: ' + record);
        }
        insert catList;
        system.debug('catlist==>'+catList);
        
    }

    global void finish(Database.BatchableContext BC) {
        // Execute any post-processing steps here
    }
}
