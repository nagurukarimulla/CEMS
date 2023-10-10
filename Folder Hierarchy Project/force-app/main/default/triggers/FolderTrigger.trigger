trigger FolderTrigger on Folder__c (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        FolderTriggerHandler.dontAllowDuplicates(Trigger.new);
    }
}