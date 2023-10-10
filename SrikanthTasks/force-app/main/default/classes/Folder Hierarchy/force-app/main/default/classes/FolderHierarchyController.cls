public with sharing class FolderHierarchyController {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getFolders() {
        List<Map<String, Object>> folderList = new List<Map<String, Object>>();

        try {
            List<Folder__c> folders = [SELECT Id, Name, Folder__c, (SELECT Id, Name FROM Folder__r) FROM Folder__c ORDER BY Name];

            for (Folder__c folder : folders) {
                Map<String, Object> folderInfo = new Map<String, Object>();
                folderInfo.put('id', folder.Id);
                folderInfo.put('name', folder.Name);
                folderInfo.put('parentId', folder.Folder__c);

                folderList.add(folderInfo);
            }
        } catch (Exception ex) {
            // Handle exception appropriately, such as logging or throwing a custom exception
            System.debug('Error occurred while retrieving folders: ' + ex.getMessage());
        }

        System.debug(folderList);
        return folderList;
    }
}