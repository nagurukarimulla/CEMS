trigger LeadApexTrigger on Lead (after insert, after update, before delete) {
    if(Trigger.isAfter && Trigger.isInsert){
        Set<Id> leadIds = new Set<Id>();
        for(Lead singleLead:Trigger.new){
            leadIds.add(singleLead.Id);
        }
        OrgToOrgLeadAPIPatch.afterInsert(leadIds);
    }

    if(Trigger.isAfter && Trigger.isUpdate){
        Set<Id> leadIds = new Set<Id>();
        for(Lead singleNewLead:Trigger.new){
            Id newLeadId = singleNewLead.Id;
            for(Lead singleOldLead:Trigger.old){
                if((singleOldLead.Name!=singleNewLead.Name) || (singleOldLead.Company!=singleNewLead.Company) || (singleOldLead.Status!=singleNewLead.Status)){
                    leadIds.add(singleNewLead.Id);
                }
            }
        }
        OrgToOrgLeadAPIPatch.afterUpdate(leadIds);
    }

    if(Trigger.isBefore && Trigger.isDelete){
        Set<Id> delLeads = new Set<Id>();
        for(Lead singleDelLead:Trigger.old){
            delLeads.add(singleDelLead.Id);
        }
        OrgToOrgLeadAPIPatch.beforeDelete(delLeads); 
        for(Id delId:delLeads){
            Id deletedId = delId;
            for(Lead delLead:Trigger.old){
                if(deletedId == delLead.Id){
                    delLead.addError('Present in destination, cant delete in source');
                }
            }
        }

    }


}