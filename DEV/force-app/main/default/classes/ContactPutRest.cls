// Setting up the Request URL
@RestResource(urlMapping='/ContactPutRest/*')
global with sharing class ContactPutRest {
    // PUT Method
    @HTTPPut
    global static Contact upsertContact(String firstName, String lastName, String phone) {
        // Initializing the request parameter with the incoming request
        RestRequest contactRequest = RestContext.request;
        // Getting the request URI
        String contactRequestURI = contactRequest.requestURI;
        // Getting the contact id from the request URI
        String contactId = contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1);
        // Initializing contact to upsert
        Contact contact = new Contact();
        // Assigning id to the contact if the contact id obtained from the URL is not empty
        if(String.isNotEmpty(contactId)) {
            contact.Id = contactId;
        }
        contact.FirstName = firstName;
        contact.LastName = lastName;
        
        contact.phone = phone;
        // Upserting Contact
        upsert contact;
        // Returning the contact in the response
        return contact;
    }
}