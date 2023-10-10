public with sharing class FolderHierarchy {
    @AuraEnabled(cacheable=true)
    public static List<TreeNode> getEmployeeFolderStructure(String recordId){
        Employee__c employeeType = [Select Id, Name, Type__c FROM Employee__c WHERE ID =: recordId];
        Folder_Hierarchy__c folderWithType = [Select Id, Name, Parent_Folders__c FROM Folder_Hierarchy__c WHERE Name =: employeeType.Type__c];
        String[] parentFolders = folderWithType.Parent_Folders__c.split(',');
        Integer sizeOfParentFolders = parentFolders.size();
        Integer i = 0;
        List<String> folderList = new List<String>();
        while(i < sizeOfParentFolders){
            String nameOfParentFolder = parentFolders[i].trim();
            folderList.add(nameOfParentFolder);
            i++;
        }

        List<Folder__c> folderStructure = [Select Id, Name, Parent_Folder__c, Parent_Folder__r.Name FROM Folder__c WHERE Parent_Folder__r.Name IN :folderList OR Name IN :folderList];

        // Create a map to store nodes based on their names
        Map<String, TreeNode> nodeMap = new Map<String, TreeNode>();

        // Populate the node map with all nodes
        for (Folder__c folder : folderStructure) {
            TreeNode node = new TreeNode();
            node.name = folder.Id;
            node.label = folder.Name;
            node.expanded = false;
            node.items = new List<TreeNode>();
            nodeMap.put(folder.Id, node);
        }

        // Build the hierarchical structure by linking child nodes to their parent nodes
        for (Folder__c folder : folderStructure) {
            if (folder.Parent_Folder__r != null) {
                TreeNode parentNode = nodeMap.get(folder.Parent_Folder__r.Id);
                TreeNode childNode = nodeMap.get(folder.Id);
                parentNode.expanded = true;
                parentNode.items.add(childNode);
            }
        }

        // Get the root nodes (nodes without parents) to return as the tree data
        List<TreeNode> rootNodes = new List<TreeNode>();
        for (TreeNode node : nodeMap.values()) {
            if (!nodeMap.get(node.name).items.isEmpty()) {
                rootNodes.add(node);
                System.debug(node);
            }
        }

        System.debug(rootNodes);
        return rootNodes;
    }


    @AuraEnabled(cacheable=true)
    public static List<ContentVersion> getFileStructure(String recordId, String selectedId){
        Employee_s_Folders__c empFolder = [Select Id, Name, Employee__c, Folder__c FROM Employee_s_Folders__c WHERE Employee__c =: recordId AND Folder__c =: selectedId];

        ContentDocumentLink cdl = [Select Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =: empFolder.Id];

        List<ContentVersion> files = [SELECT Id, ContentDocumentId, Title, Description FROM ContentVersion WHERE ContentDocumentId =: cdl.ContentDocumentId];

        return files;

    }

    public class TreeNode {
        @AuraEnabled
        public String name;

        @AuraEnabled
        public String label;
        
        @AuraEnabled
        public Boolean expanded;
        
        @AuraEnabled
        public List<TreeNode> items;
    }
}

//FolderHierarchy.getEmployeeFolderStructure('a2gDP000001hLy8YAE');