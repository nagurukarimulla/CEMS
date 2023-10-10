public with sharing class SearchController {
    @AuraEnabled
    public static List<sObject> searchRecords(String searchkey , String fieldApi , String objectName , List<String> requiredFields){
     try {
         String searhValue = '%'+searchkey+'%';
         String query ='SELECT Id ';
         for(String field : requiredFields){
             query +=','+field+' ';
         }
         query += 'FROM '+objectName+' WHERE '+fieldApi+' LIKE :searhValue ';
         system.debug('-> '+query);
         List<sObject> records = Database.query(query);
         return records;
     } catch (Exception e) {
         throw new AuraHandledException(e.getMessage());
     }
    }
 
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