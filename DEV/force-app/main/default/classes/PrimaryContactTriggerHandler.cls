public class PrimaryContactTriggerHandler {
    public static void primaryContact(List<Contact> newList){
        
	set<Id> getId = new set<Id>();
    Id contactId;
    Boolean flag = false;
    List<Contact> contactList = new List<Contact>();
    
    //Trigger 
        for(Contact cont:newList){
            if(cont.primaryContact__c == true){
                getId.add(cont.AccountId);
                contactId=cont.Id;
            }
        }
    
    //Retrieving the other contact which has primary contact checked 
    List<Contact> conList = [select Id, primaryContact__c from contact where accountId IN:getId AND primaryContact__c=true];
    
    //trying to add error message the already checked primary contact
    if(conList.size()>0){
        for(Contact newCont:conList){
            if(newCont.Id != contactId){
                flag = true;
                //contactList.add(newCont);
            }
        }
        
        for(Contact newCon : newList){
            if(flag){
                newCon.primaryContact__c.addError('Multiple contacts cannot be marked as primary on the same Account');
            }
        }
    	update contactList;
    }
}
}