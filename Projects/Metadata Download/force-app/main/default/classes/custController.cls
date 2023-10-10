public with sharing class custController {
    @AuraEnabled(cacheable=true)
    public static String getXmlData() {
        List<CustomObject__c> records = [SELECT Field1__c, Field2__c, Field3__c FROM CustomObject__c];
        return JSON.serialize(records);
    }
}