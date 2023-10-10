public class CommonHelper {
    Public static void doDmlOperations(){
        User userToDeactivate = [Select id, username, isActive from user where username = 'tester2@gmail.com' 
                                limit 1];
        if(userToDeactivate.id !=null){
            userToDeactivate.IsActive = false;
            update userToDeactivate;
            schoolRecord();
        }
    }
    @future
    public static void schoolRecord(){
        School__c sc = new School__c();
        sc.Name = 'JNTUH';
        sc.School_Address__c = 'Hyd';
        sc.School_Phone__c = '9080909800';
        sc.School_Email__c = 'jntuh@jntu.com';
        insert sc;
    }
}