trigger CheckAccountExistsOrNot on Contact (before delete) {
    for(Contact contact : Trigger.old){
        if(contact.AccountId==null){
            contact.addError('You cant delete this contact');
        }
    }
}