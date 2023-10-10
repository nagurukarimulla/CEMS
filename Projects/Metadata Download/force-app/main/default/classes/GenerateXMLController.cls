public with sharing class GenerateXMLController {
    @AuraEnabled
    public static String generateXML(Id recordId) {
        Account acc = [SELECT Id, Name, Type, Industry FROM Account WHERE Id = :recordId];
        Dom.Document doc = new Dom.Document();
        Dom.Element root = doc.createElement('Account');
        doc.appendChild(root);
        Dom.Element nameNode = doc.createElement('Name');
        nameNode.appendChild(doc.createTextNode(acc.Name));
        root.appendChild(nameNode);
        Dom.Element typeNode = doc.createElement('Type');
        typeNode.appendChild(doc.createTextNode(acc.Type));
        root.appendChild(typeNode);
        Dom.Element industryNode = doc.createElement('Industry');
        industryNode.appendChild(doc.createTextNode(acc.Industry));
        root.appendChild(industryNode);
        return doc.toXmlString();
    }
}
