public with sharing class SearchController {
    @AuraEnabled
    public static List<SObject> searchRecords(String searchKey,List<String> displayFields,String fieldApi,String objectName){
        try {
            String searchValue=searchKey;
            String val = '\'%'+String.escapeSingleQuotes(searchValue.trim())+'%\'';
            String query='SELECT Id ';
        
            for(String field : displayFields)
            {
                //system.debug('API Name ====>' + field); 
                query+=','+field+ ' ';
                
            }
                //System.debug(query);
        
            query+= 'FROM '+objectName+' WHERE '+fieldApi+' LIKE '+  val ;
            System.debug(query);
    
            List<SObject> records =Database.query(query);
            System.debug(records);
            return records;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    
    }
    
    @AuraEnabled
    public static List<string> getDisplayFields(String objectName, String fieldSetName){
        try {
            return getFields(objectName, fieldSetName);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    
    }
    
    private static List<String> getFields(String objectName,String fieldSetName){
        List<String> results = new List<String>();
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.fieldSets.getMap().get(fieldSetName);
        List<Schema.FieldSetMember> fieldSetMemberList =  fieldSetObj.getFields();
        System.debug('fieldSetMemberList ====>' + fieldSetMemberList); 
        for(Schema.FieldSetMember field : fieldSetMemberList)
        {
            results.add(field.getFieldPath());
            
        }
        return results;
    }
    //searchController.searchRecords('Hasim','myappmarket__SearchComponentFieldSet','Name','Account');
    @AuraEnabled
    public static sObject saveRecord(String sObjectString , String sObjectName ){
     try {
         
         object value = (object)System.JSON.deserializeUntyped(sObjectString);
         Map<String,Object> vMap = (Map<String,Object>)value;
         Schema.SObjectType targetType = Schema.getGlobalDescribe().get(sObjectName);
         Sobject sObj = targetType.newSObject();
         Map<String , Schema.SObjectField> fields = targetType.getDescribe().fields.getMap();
         for(String fieldName : vMap.keyset()){
             system.debug('FIELD Names : '+fieldName);
             Schema.SObjectField fi = fields.get(fieldName);
             if(fi != null){
                 if(fieldName == 'Id'){
                     sObj.put(fieldName,Id.valueOf(String.valueof(vMap.get(fieldName))));
                 }
                 // Updatable or not now ?
                 if(fi.getDescribe().isUpdateable()){
                     String fieldDataType = String.valueOf(fi.getDescribe().getType());
                     if(fieldDataType == 'DateTime'){
                         DateTime dtvalue = DateTime.valueof(String.valueof(vMap.get(fieldName)));
                         sObj.put(fieldName,dtvalue);
                     }
                     else if(fieldDataType == 'CURRENCY'){
                         Decimal cValue = Decimal.valueof(String.valueof(vMap.get(fieldName)));
                         sObj.put(fieldName,cValue);
                     }
                     else{
                         sObj.put(fieldName,String.valueof(vMap.get(fieldName)));
                     }
                 }
             }
         }
         system.debug('vMap '+vMap);
         system.debug('sObj '+sObj);
         update sObj;
         return sObj;
     } catch (Exception e) {
         throw new AuraHandledException(e.getMessage());
     }
    }
    }