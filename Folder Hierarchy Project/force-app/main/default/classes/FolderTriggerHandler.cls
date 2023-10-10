public with sharing class FolderTriggerHandler {
    public static void dontAllowDuplicates(List<Folder__c> newFolderList) {

        Map<Id, String> currentRecordName = new Map<Id, String>();
        for(Folder__c folderRecord : newFolderList){
            currentRecordName.put(folderRecord.Parent_Folder__c, folderRecord.Name);
        }

        Map<Id, Folder__c> folderRecords = new Map<Id, Folder__c>([Select Id, Name, Parent_Folder__c FROM Folder__c WHERE Name IN : currentRecordName.values() AND Parent_Folder__c IN : currentRecordName.keySet()]);

        Map<Id, String> exisitingRecords = new Map<Id, String>();
        for(Folder__c existingRecord : folderRecords.values()){
            exisitingRecords.put(existingRecord.Parent_Folder__c, existingRecord.Name);
        }

        for(Folder__c currentRec : newFolderList){
            if(exisitingRecords.containsKey(currentRec.Parent_Folder__c)){
                if(exisitingRecords.get(currentRec.Parent_Folder__c).equalsIgnoreCase(currentRec.Name)){
                    currentRec.addError('Already Record With Same Parent Exists');
                }
            }
        }
    }
}