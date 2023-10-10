public class contactControllerCls {
 @AuraEnabled
    public static List<Contact> getContacts(String recId) {
        List<Contact> contacts =
                [SELECT Id, Name, AccountId, Phone, Email 
                 FROM Contact WHERE AccountId=:recId
      
                ];
        
       return contacts;
    }
}