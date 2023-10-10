public with sharing class TestCustomObjectXml {
    @AuraEnabled(cacheable=true)
    public static String generateXMLFile(String objectName) {
       /*
        // Retrieve the metadata for the custom object
        CaptutrAuditTrails__c customObject = [SELECT Action__c, Name,Display__c, Section__c,CreatedByName__c, CreatedDate__c FROM CustomObCaptutrAuditTrails__cject WHERE Name = :objectName];

        // Build the XML string
        Dom.Document doc = new Dom.Document();
        Dom.XmlNode rootNode = doc.createRootElement('CustomObject', 'http://soap.sforce.com/2006/04/metadata');
        rootNode.addChildElement('Name', customObject.Name);
        rootNode.addChildElement('Display', customObject.Display__c);
        rootNode.addChildElement('Action', customObject.Action__c);
        rootNode.addChildElement('Section', customObject.Section__c);
        rootNode.addChildElement('CreatedByName', customObject.CreatedByName__c);
        rootNode.addChildElement('CreatedDate', customObject.CreatedDate__c);
        return doc.toXmlString();*/
        List<CaptutrAuditTrails__c> cap = [Select Id,Name,Display__c,CreatedByName__c, CreatedDate__c,Section__c From  CaptutrAuditTrails__c];
        
        
        Dom.Document doc = new Dom.Document(); 
        // Dom.XmlNode textNode = doc.createText('\n');
        Dom.Xmlnode rootinnerNode = doc.createRootElement('Package xmlns="http://soap.sforce.com/2006/04/metadata" \n', null, null); 
        
        for (CaptutrAuditTrails__c Product: cap ) {
            // Dom.Xmlnode ProductNode = rootNode.addChildElement('Items', null, null);
            
            Dom.Xmlnode rootParentNode = rootinnerNode.addChildElement('types', null, null);
           // rootinnerNode.addCommentNode('types\n'); 
            
           rootParentNode.addChildElement('members\n', null, null).addTextNode(Product.Display__c); 
           
            
           rootParentNode.addChildElement('names\n', null, null).addTextNode(Product.CreatedByName__c);
        
           //rootParentNode.addChildElement('names\n', null, null).addTextNode(Product.CreatedDate__c);
        
           rootParentNode.addChildElement('names\n', null, null).addTextNode(Product.Section__c);
        
        
            
        }   
         
        //rootinnerNode.insertChildElement(index,textNode);
        
        // Dom.XmlNode finalnode = rootNode.addChildElement(name, null, null);
        system.debug(doc.toXmlString());
        return doc.toXmlString();

    }
}

/*
List<CaptutrAuditTrails__c> cap = [Select Id,Name,Display__c,CreatedByName__c, CreatedDate__c,Section__c From  CaptutrAuditTrails__c];
        
        
Dom.Document doc = new Dom.Document(); 
// Dom.XmlNode textNode = doc.createText('\n');
Dom.Xmlnode rootinnerNode = doc.createRootElement('Package xmlns="http://soap.sforce.com/2006/04/metadata" \n', null, null); 

for (Package__c Product: packList ) {
    // Dom.Xmlnode ProductNode = rootNode.addChildElement('Items', null, null);
    
    Dom.Xmlnode rootParentNode = rootinnerNode.addChildElement('types', null, null);
   // rootinnerNode.addCommentNode('types\n'); 
    
   rootParentNode.addChildElement('members\n', null, null).addTextNode(Product.Display__c); 
   
    
   rootParentNode.addChildElement('names\n', null, null).addTextNode(Product.CreatedByName__c);

   rootParentNode.addChildElement('names\n', null, null).addTextNode(Product.CreatedDate__c);

   rootParentNode.addChildElement('names\n', null, null).addTextNode(Product.Section__c);


    
}   
 
//rootinnerNode.insertChildElement(index,textNode);

// Dom.XmlNode finalnode = rootNode.addChildElement(name, null, null);
system.debug(doc.toXmlString());
return doc.toXmlString();

*/