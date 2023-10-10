/*
public with sharing class PackageClass {
    
    @AuraEnabled(cacheable=true)
    public static String getMetadata(){
        
        List<CaptutrAuditTrails__c> trailList = [SELECT Id, Name, Action__c, CreatedByName__c, CreatedDate__c, Display__c, Section__c FROM CaptutrAuditTrails__c ];
        
        Map<String,List<CaptutrAuditTrails__c>> trailMap = new Map<String,List<CaptutrAuditTrails__c>>();
        
        Dom.Document doc = new Dom.Document(); 


        Dom.Xmlnode rootinnerNode = doc.createRootElement('Package', 'http://soap.sforce.com/2006/04/metadata','');
        
        for(CaptutrAuditTrails__c audit: trailList ) {
            if(audit.Section__c != null) {
                // Create a new list for each Apex class
               // List<CaptutrAuditTrails__c> trailList2 = new List<CaptutrAuditTrails__c>();
               // trailList2.add(audit);
               // System.debug(trailList2);
               // trailMap.put(audit.Section__c, trailList2);
            //} else 
            //{
                // Add the Custom Object to the existing list
                List<CaptutrAuditTrails__c> trailList2 = trailMap.get(audit.Section__c);
                if (trailList2 == null) {
                    trailList2 = new List<CaptutrAuditTrails__c>();
                    trailMap.put(audit.Section__c, trailList2);
                }
                trailList2.add(audit);
            }
        
        }

        for (String keyOfMap : trailMap.keySet()){
            Dom.Xmlnode rootParentNode = rootinnerNode.addChildElement('types', null, null);

            rootParentNode.addTextNode('\n');
            for (CaptutrAuditTrails__c trail : trailMap.get(keyOfMap)) {
                rootParentNode.addChildElement('members', null, null).addTextNode(trail.Action__c);
                rootParentNode.addTextNode('\n');
                rootParentNode.addChildElement('members', null, null).addTextNode(trail.Display__c); 
                rootParentNode.addTextNode('\n');
            }
            rootParentNode.addChildElement('name', null, null).addTextNode(keyOfMap);
            rootParentNode.addTextNode('\n');
        }
        String xmlString = doc.toXmlString();
        xmlString = xmlString.replace('</types>', '</types>\n');
        return xmlString;
    }
}

*/
/*
public with sharing class PackageClass {
    
    @AuraEnabled(cacheable=true)
    public static String getMetadata(){
        
        List<CaptutrAuditTrails__c> trailList = [SELECT Id, Name, Action__c, CreatedByName__c, CreatedDate__c, Display__c, Section__c FROM CaptutrAuditTrails__c];
        
        Map<String,List<CaptutrAuditTrails__c>> trailMap = new Map<String,List<CaptutrAuditTrails__c>>();
        
        Dom.Document doc = new Dom.Document(); 


        Dom.Xmlnode rootinnerNode = doc.createRootElement('Package', 'http://soap.sforce.com/2006/04/metadata','');
        
        List<String> fieldList = new List<String>{'Action__c', 'Display__c'};
        
        for(CaptutrAuditTrails__c audit: trailList ) {
            if(audit.Section__c == 'Apex Class') {
                // Create a new list for each Apex class
                List<CaptutrAuditTrails__c> trailList2 = new List<CaptutrAuditTrails__c>();
                trailList2.add(audit);
                System.debug(trailList2);
                trailMap.put(audit.Section__c, trailList2);
            } else {
                // Add the Custom Object to the existing list
                List<CaptutrAuditTrails__c> trailList2 = trailMap.get(audit.Section__c);
                if (trailList2 == null) {
                    trailList2 = new List<CaptutrAuditTrails__c>();
                    trailMap.put(audit.Section__c, trailList2);
                }
                trailList2.add(audit);
            }
        
        }

        for (String keyOfMap : trailMap.keySet()){
            Dom.Xmlnode rootParentNode = rootinnerNode.addChildElement('types', null, null);

            rootParentNode.addTextNode('\n');
            for (CaptutrAuditTrails__c trail : trailMap.get(keyOfMap)) {
                for (String fieldName : fieldList) {
                    rootParentNode.addChildElement('members', null, null).addTextNode(String.valueOf(trail.get(fieldName)));
                    rootParentNode.addTextNode('\n');
                }
            }
            rootParentNode.addChildElement('name', null, null).addTextNode(keyOfMap);
            rootParentNode.addTextNode('\n');
        }
        String xmlString = doc.toXmlString();
        xmlString = xmlString.replace('</types>', '</types>\n');
        return xmlString;
    }
}
*/

public with sharing class PackageClass {
    @AuraEnabled(cacheable=true)
    public static String getMetadata(){
        List<CaptutrAuditTrails__c> trailList = [SELECT Id, Name, Action__c, CreatedByName__c, CreatedDate__c, Display__c, Section__c FROM CaptutrAuditTrails__c];
        
        Map<String,Set<String>> trailMap = new Map<String,Set<String>>();
        
        Dom.Document doc = new Dom.Document(); 
        
        Dom.Xmlnode rootinnerNode = doc.createRootElement('Package', 'http://soap.sforce.com/2006/04/metadata', ''); 

        rootinnerNode.addTextNode('\n');
        Set<String> trailList2 = new Set<String>();
        for (CaptutrAuditTrails__c audit: trailList ) {
            String section = audit.Section__c;
            Set<String> displaySet = new Set<String>();
            if(trailMap.containsKey(section)){
                String display = audit.Display__c;
                Set<String> setOfDisplay = trailMap.get(section);
                setOfDisplay.add(display);
                trailMap.put(section, setOfDisplay);
            }
            else{
                String display = audit.Display__c;
                displaySet.add(display);
                trailMap.put(section, displaySet);
            }
        }
        System.debug(trailMap);
        for (String keyOfMap : trailMap.keySet()){
          
            Dom.Xmlnode rootParentNode = rootinnerNode.addChildElement('types', null, null);
            rootParentNode.addTextNode('\n');
            for (String trail : trailMap.get(keyOfMap)) {
                //rootParentNode.addChildElement('members', null, null).addTextNode(trail.Action__c);
                //rootParentNode.addTextNode('\n');
                rootParentNode.addChildElement('members', null, null).addTextNode(trail); 
                rootParentNode.addTextNode('\n');
            }
            rootParentNode.addChildElement('name', null, null).addTextNode(keyOfMap);
            rootParentNode.addTextNode('\n');
        }
        String xmlString = doc.toXmlString();
        xmlString = xmlString.replace('<types>', '<types>\n');
        return xmlString;
    }
}