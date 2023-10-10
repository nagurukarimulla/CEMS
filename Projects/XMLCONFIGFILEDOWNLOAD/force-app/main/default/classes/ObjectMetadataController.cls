public with sharing class ObjectMetadataController {
    @AuraEnabled(cacheable=true)
    public static Map<String, List<String>> getObjectMetadata() {
        Map<String, List<String>> objectFields = new Map<String, List<String>>();
        Map<String, Schema.SObjectType> globalMap = Schema.getGlobalDescribe();
        for (Schema.SObjectType sobjectType : globalMap.values()) {
            if (sobjectType.getDescribe().isQueryable()) {
                Schema.DescribeSObjectResult describeResult = sobjectType.getDescribe();
                Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();
                List<String> fieldNames = new List<String>();
                for (Schema.SObjectField field : fieldMap.values()) {
                    if (field.getDescribe().isAccessible()) {
                        fieldNames.add(field.getDescribe().getName());
                    }
                }
                objectFields.put(describeResult.getName(), fieldNames);
            }
        }
        return objectFields;
    }
    @AuraEnabled(cacheable=true)
    public static List<String> getObjectFields(String objectName) {
        List<String> fieldNames = new List<String>();
        Schema.DescribeSObjectResult describeResult = Schema.getGlobalDescribe().get(objectName).getDescribe();
        Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();
        for (Schema.SObjectField field : fieldMap.values()) {
            if (field.getDescribe().isAccessible()) {
                fieldNames.add(field.getDescribe().getName());
            }
        }
        return fieldNames;
    }
}
