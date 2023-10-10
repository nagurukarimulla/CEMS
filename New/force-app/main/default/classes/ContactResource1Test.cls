@isTest
global class ContactResource1Test  {
 @TestSetup
    static void makeData() {
        // Inserting a new contact
        Contact contactTest = new Contact(FirstName='brock', LastName='lesnar');
        insert contactTest;
    }
     // Testing the GET request
    @isTest
    static void testGetContactIdAndNames() {
        System.Test.startTest();
        // Forming the request
        RestRequest contactRequest = new RestRequest();
        contactRequest.requestUri = 'https://cittacoretechnologiesindial-dev-ed.my.salesforce.com/services/apexrest/ContactAPI1/1';
        contactRequest.httpMethod = 'GET';
        RestContext.request = contactRequest;
        // Testing the API
        List<Contact> returnedContacts = ContactResource1.getContactIdAndNames();
        // Confirming the response
        System.assert(returnedContacts != null);
        System.assert(returnedContacts.size() == 1);
        System.assertEquals('brock', returnedContacts[0].Name);
        System.Test.stopTest();
    }
}