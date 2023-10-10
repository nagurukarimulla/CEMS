trigger createDummyContacttrigger on Account (after insert) {
    List<Contact> contactList = new List<Contact>();
    for(Account acc : trigger.new){
        Contact cont = new Contact();
        cont.Lastname = acc.Name;
        cont.firstname = 'Dummy';
        cont.AccountId = acc.Id;
        cont.MailingCity = acc.BillingCity;
        cont.MailingStreet = acc.BillingStreet;
        cont.MailingState = acc.BillingState;
        contactList.add(cont);
    }
    insert contactList;
}