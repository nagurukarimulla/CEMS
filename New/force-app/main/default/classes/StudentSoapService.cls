global class StudentSoapService
{
    webService static Student__c getStudentById(String studentId)
    {
       Student__c student=[select id,Student_Name__c,Class_Enrolled__c,Phone_Number__c,School__c,Email__c from Student__c where id=: studentId];
      return student;
    }

}