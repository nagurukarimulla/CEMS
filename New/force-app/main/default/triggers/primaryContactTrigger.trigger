trigger primaryContactTrigger on Contact (before insert, before update) {
    PrimaryContactTriggerHandler.primaryContact(Trigger.new);
}