public with sharing class GenerateXML {
    @AuraEnabled(cacheable=true)
    public static String generateXMLFile() {
    
    String xmlString = '<?xml version="1.0" encoding="UTF-8"?>\n  <Package xmlns="http://soap.sforce.com/2006/04/metadata">\n <version>56.0</version>\n'; 
    //'<CustomObjects>\n';
    List<CustomObject__c> myObjects =  [SELECT Id, Name, ApexTrigger__c, ApexClass__c, CustomObject__c, CustomField__c,Field1__c, Field2__c, Field3__c FROM CustomObject__c];
    xmlString += '\t<types>\n';
    for (CustomObject__c customObject : myObjects){ 
    xmlString += '\t\t<members>' + customObject.ApexTrigger__c + '</members>\n';
    }
    xmlString += '\t</types>\n </Package>\n';
    return xmlString;
    }
    
    }