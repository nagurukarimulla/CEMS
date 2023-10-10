public with sharing class ContactDetailsController {
    @AuraEnabled(cacheable=true)
    public static Contact getContact(Id recordId) {
        return [SELECT Id, Name, Title, Phone, Email, Account.Name FROM Contact WHERE Id = :recordId];
    }
}