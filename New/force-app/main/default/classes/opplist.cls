public class opplist {
 @AuraEnabled
    public static list<opportunity> getopplist(){
        
        list<opportunity> opps = new list<opportunity>([select Id,AccountId,probability,stageName from opportunity]);
        return opps;
    }
}