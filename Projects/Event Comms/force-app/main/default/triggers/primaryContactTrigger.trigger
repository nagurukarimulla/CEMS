trigger primaryContactTrigger on Contact (before insert, before update) {
    if(trigger.isBefore && trigger.isInsert){
        contactTriggerHandler.preventCreatePrimaryContactOnInsert(trigger.new);
    }
    
    if(trigger.isBefore && trigger.isUpdate){
        contactTriggerHandler.preventCreatePrimaryContactOnUpdate(Trigger.newMap,Trigger.oldMap);
    }
}