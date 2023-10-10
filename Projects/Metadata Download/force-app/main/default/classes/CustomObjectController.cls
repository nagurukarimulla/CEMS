public with sharing class CustomObjectController {
    @AuraEnabled(cacheable=true)
    public static String generateXml(){
        List<CustomObject__c> objectList = [SELECT Field1__c, Field2__c FROM CustomObject__c];
        XmlStreamWriter writer = new XmlStreamWriter();
        String xmlString;
        writer.writeStartDocument('UTF-8', '1.0');
        writer.writeStartElement(null, 'CustomObject__c', null);
        for(CustomObject__c obj : objectList){
            writer.writeStartElement(null, 'Field1__c', null);
            writer.writeCharacters(obj.Field1__c);
            writer.writeEndElement();
            writer.writeStartElement(null, 'Field2__c', null);
            writer.writeCharacters(obj.Field2__c);
            writer.writeEndElement();
        }
        writer.writeEndElement();
        xmlString = writer.getXmlString();
        return xmlString;
     }
}

CustomObjectXMLGenerator