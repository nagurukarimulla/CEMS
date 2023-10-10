trigger ContactTrigger on Contact (after insert, after update) {
contact c1 = new contact();
    String fname;
    String lname, title, emailid;
    Id id1;
    contact c2 = Trigger.new[0];
    System.debug('Before the if:'+c2.LastName);
    if(c2.LastName != null){
        System.debug('@@@@@@@@@@@@@@@@@@@@@'+'Contact Trigger Called');
        sendContactToExternalSystem instance = new sendContactToExternalSystem();
        instance.sendContact(c2.firstname, c2.lastName, c2.title, c2.email, c2.Id);
    }
}