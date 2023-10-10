public with sharing class SObjectService {
    @AuraEnabled(cacheable=true)
    public static string getPropertyType(String actionType) {
        try {
            if(actionType == 'WireProperty'){
              return 'wire property';
            }
            else if(actionType == 'WireFunction'){
                return 'Wire Function';
            }
            else if(actionType == 'Imperative'){
                return 'Imperative Execution';
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return null;
    }
}