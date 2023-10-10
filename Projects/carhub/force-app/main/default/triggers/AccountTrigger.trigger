trigger AccountTrigger on Account (before insert , after insert ,
                                    before update , after update , before delete , 
                                    after delete , after undelete) {

   // Trigger don't have methods
   if(Trigger.isBefore && Trigger.isInsert){
    AccountTriggerHandler.beforeInsert(Trigger.new);
   } 
   if(Trigger.isBefore && Trigger.IsUpdate){
    AccountTriggerHandler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
   }
}