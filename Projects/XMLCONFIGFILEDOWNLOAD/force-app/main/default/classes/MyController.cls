public with sharing class MyController
 { 
    @AuraEnabled(cacheable=true)
    public static List<ObjectInfo> getObjectList() {
        List<ObjectInfo> objectList = new List<ObjectInfo>();
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        for (String objectName : globalDescribe.keySet()) {
            Schema.SObjectType objectType = globalDescribe.get(objectName);
            if (objectType.getDescribe().isQueryable()) {
                objectList.add(new ObjectInfo(objectName, objectType.getDescribe().getLabel()));
            }
        }
        return objectList;
    }
    
    public class ObjectInfo {
        @AuraEnabled public String name;
        @AuraEnabled public String label;
        
        public ObjectInfo(String name, String label) {
            this.name = name;
            this.label = label;
        }
    }
}
    
//MyController m = new MyController();
//m.getAllObjectNames();
