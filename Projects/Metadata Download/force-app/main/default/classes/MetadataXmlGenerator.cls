public with sharing class MetadataXmlGenerator {
    public static String generateMetadataXml() {
        // create XMLStreamWriter object
        XMLStreamWriter writer = new XMLStreamWriter();
        // write XML data
        writer.writeStartDocument('UTF-8', '1.0');
        writer.writeStartElement(null, 'metadata', null);
        // add metadata nodes
        writer.writeEndElement();
        writer.writeEndDocument();
        // return XML data as a string
        return writer.getXmlString();
      }
      @AuraEnabled(cacheable=true)
public static String getMetadataXml() {
  return MetadataXmlGenerator.generateMetadataXml();
}
}

