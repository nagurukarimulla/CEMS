trigger contactBeforeInsert on Contact (before update) {
    for(Contact contact : Trigger.New){
        contact.Description = 'Contact updated by karim';
}
}