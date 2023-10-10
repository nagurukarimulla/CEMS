public with sharing class CustomObjectXMLGenerator {
    @AuraEnabled(cacheable=true)
    public static String generateXMLFile() {
        // Get the schema for the custom object
        Schema.DescribeSObjectResult describeResult = Package__c.SObjectType.getDescribe();
        System.debug(describeResult);
        Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();
        System.debug(fieldMap);
        
        // Create the XML document
        DOM.Document xmlDocument = new DOM.Document();
        DOM.XmlNode rootNode = xmlDocument.createRootElement(describeResult.getName(), null, null);
        
        // Add fields as child nodes to the root node
        for (String fieldName : fieldMap.keySet()) {
            if(fieldName == 'fieldapi__c' || fieldName == 'fieldvalue__c'){
            Schema.SObjectField field = fieldMap.get(fieldName);
            DOM.XmlNode fieldNode = rootNode.addChildElement(fieldName, null, null);
            fieldNode.addTextNode(field.getDescribe().getName());
            }
        }
        
        // Serialize the XML document to a string
        String xmlString = xmlDocument.toXmlString();
        
        
      //  DOM.Document xmlDoc = new DOM.Document();
       // xmlDocument.load(xmlString);

// Serialize the DOM document to a string
       // String formattedXmlString = xmlDoc.toXmlString();
         System.debug(xmlString);
        return XmlString;
    }
}