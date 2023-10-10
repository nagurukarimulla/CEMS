public with sharing class MetadataController {
    @AuraEnabled(cacheable=true)
    public static String retrieveMetadata(String objectName) {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        
        String[] types = new String[] {'CustomObject', 'ApexClass', 'ApexTrigger', 'ApexPage', 'ApexComponent', 'CustomField', 'ValidationRule', 'RecordType'};
        MetadataService.Metadata[] metadataList = new List<MetadataService.Metadata>();
        for (String type : types) {
            MetadataService.Metadata metadata = new MetadataService.Metadata();
            metadata.type_x = type;
            metadata.fullNames = new String[]{objectName};
            metadataList.add(metadata);
        }
        
        MetadataService.Metadata[] metadata = service.readMetadata(metadataList, null).getRecords();
        
        DOM.Document document = metadata.toXmlDocument();
        
        return document.toXmlString();
    }
}
