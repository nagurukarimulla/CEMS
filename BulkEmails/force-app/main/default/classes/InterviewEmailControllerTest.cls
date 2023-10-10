@isTest
public class InterviewEmailControllerTest {
    @isTest
    static void testGetInterviewRecords() {
         EMS_Applicant__c applicant = new EMS_Applicant__c(EMS_Email__c='testcandidate@example.com',EMS_Mobile__c='+918090908090', EMS_Last_Name__c = 'Karim');
    insert applicant;
    
    EMS_Employee__c interviewer = new EMS_Employee__c(Name='Naguru', EMS_Type__c='Full Time', EMS_Work_Email__c='testinterviewer@example.com');
    insert interviewer;
    
    EMS_Position__c position = new EMS_Position__c(Name='Test Position',EMS_Required_Skills__c = 'System Administrator', EMS_Status__c='Active');
    insert position; 
    
    EMS_Job_Opening__c jobopening = new EMS_Job_Opening__c();
    jobopening.EMS_Department__c = 'Finance';
    jobopening.EMS_Experience__c = '1 - 2 Yrs';
     jobopening.EMS_Educational_Requirements__c = 'B.Tech/B.E';
     jobopening.EMS_Minimum_Salary__c = 9000;
    jobopening.EMS_Location__c = 'Hyderabad - Telangana';
    jobopening.EMS_Open_Date__c = Date.today();
     jobopening.Hire_by_Date__c = Date.today();
     jobopening.EMS_Maximum_Salary__c = 70000;
    jobopening.EMS_Job_Title__c = position.Id;
        jobopening.EMS_No_of_Openings__c = 10;
      insert jobopening;
    
    EMS_Job_Applications__c jobApp = new EMS_Job_Applications__c(EMS_Applicant__c=applicant.Id, EMS_Stage__c='Pre-Screening', EMS_Status__c='Passed', EMS_Job_Opening__c=jobopening.Id);
    insert jobApp;
        // Create test data
        EMS_Interview_Scheduling__c interview = new EMS_Interview_Scheduling__c(
            EMS_Interview_Date__c = Date.today().addDays(8),
            EMS_Interview_Start_Time_c__c = DateTime.newInstance(2023,4,20, 10, 30, 9),
            EMS_InterviewEndTime__c = DateTime.newInstance(2023,4,20, 10, 45, 9),
            EMS_Interview_Type__c = 'In Person Interview',
            //EMS_Interviewer_Email__c = 'test-interviewer@test.com',
            //EMS_Applicant_Email__c = 'test-applicant@test.com',
            EMS_Interview_Location__c = 'Hyd',
            EMS_Interview_Round__c = 'Technical Round',
            EMS_Interview_Stage__c = 'Scheduled',
            EMS_Interview_Status__c = 'Accepted',
            EMS_Job_Application_ID__c = jobApp.Id
             
        );
        insert interview;

        // Call the method
        List<EMS_Interview_Scheduling__c> interviewList = InterviewEmailController.getInterviewRecords();

        // Verify the result
        System.assertEquals(1, interviewList.size());
        System.assertEquals(interview.Id, interviewList[0].Id);
        //System.assertEquals(interview.EMS_Interview_Date__c, interviewList[0].EMS_Interview_Date__c);
        System.assertEquals(interview.EMS_Interview_Start_Time_c__c, interviewList[0].EMS_Interview_Start_Time_c__c);
        System.assertEquals(interview.EMS_InterviewEndTime__c, interviewList[0].EMS_InterviewEndTime__c);
        System.assertEquals(interview.EMS_Interview_Type__c, interviewList[0].EMS_Interview_Type__c);
        //System.assertEquals(interview.EMS_Interviewer_Email__c, interviewList[0].EMS_Interviewer_Email__c);
        //System.assertEquals(interview.EMS_Applicant_Email__c, interviewList[0].EMS_Applicant_Email__c);
        System.assertEquals(interview.EMS_Interview_Location__c, interviewList[0].EMS_Interview_Location__c);
        System.assertEquals(interview.EMS_Interview_Round__c, interviewList[0].EMS_Interview_Round__c);
        System.assertEquals(interview.EMS_Interview_Stage__c, interviewList[0].EMS_Interview_Stage__c);
        System.assertEquals(interview.EMS_Interview_Status__c, interviewList[0].EMS_Interview_Status__c);
    }

    
    @isTest
   static void testSendBulkEmails() {
    
    EMS_Applicant__c applicant = new EMS_Applicant__c(EMS_Email__c='testcandidate@example.com',EMS_Mobile__c='+918090908090', EMS_Last_Name__c = 'Karim');
    insert applicant;
    
    EMS_Employee__c interviewer = new EMS_Employee__c(Name='Naguru', EMS_Type__c='Full Time', EMS_Work_Email__c='testinterviewer@example.com');
    insert interviewer;
    
    EMS_Position__c position = new EMS_Position__c(Name='Test Position',EMS_Required_Skills__c = 'System Administrator', EMS_Status__c='Active');
    insert position; 
    
    EMS_Job_Opening__c jobopening = new EMS_Job_Opening__c();
    jobopening.EMS_Department__c = 'Finance';
    jobopening.EMS_Experience__c = '1 - 2 Yrs';
     jobopening.EMS_Educational_Requirements__c = 'B.Tech/B.E';
     jobopening.EMS_Minimum_Salary__c = 9000;
    jobopening.EMS_Location__c = 'Hyderabad - Telangana';
    jobopening.EMS_Open_Date__c = Date.today();
     jobopening.Hire_by_Date__c = Date.today();
     jobopening.EMS_Maximum_Salary__c = 70000;
    jobopening.EMS_Job_Title__c = position.Id;
        jobopening.EMS_No_of_Openings__c = 10;
      insert jobopening;
    
    EMS_Job_Applications__c jobApp = new EMS_Job_Applications__c(EMS_Applicant__c=applicant.Id, EMS_Stage__c='Pre-Screening', EMS_Status__c='Passed', EMS_Job_Opening__c=jobopening.Id);
    insert jobApp;
       
       EMS_Employee__c emp = new EMS_Employee__c(Name='Arpit Agarwal', EMS_Type__c='Full Time', EMS_Work_Email__c='test-interviewer@test.com');
       insert emp;
        // Create test data
        EMS_Interview_Scheduling__c interview = new EMS_Interview_Scheduling__c(
            EMS_Interview_Date__c = Date.today().addDays(8),
            EMS_Interview_Start_Time_c__c = DateTime.newInstance(2023,4,20, 10, 30, 9),
            EMS_InterviewEndTime__c = DateTime.newInstance(2023,4,20, 10, 45, 9),
            EMS_Interview_Type__c = 'In Person Interview',
            EMS_Interviewer_2_Name__c = emp.Id,
            EMS_Interviewer_1_Name__c = emp.Id,
            //EMS_Interviewer_Email__c = emp.EMS_Work_Email__c,
            //EMS_Applicant_Email__c = 'test-applicant@test.com',
            EMS_Interview_Location__c = 'Hyd',
            EMS_Interview_Round__c = 'Technical Round',
            EMS_Interview_Stage__c = 'Scheduled',
            EMS_Interview_Status__c = 'Accepted',
            EMS_Job_Application_ID__c = jobApp.Id
             
        );
        insert interview;
    
    Test.startTest();
    
    // Call the method under test with the interview Id
    List<Id> interviewIds = new List<Id>{interview.Id};
    InterviewEmailController.sendBulkEmails(interviewIds);
    Test.stopTest();
    String subject;
    String body;
    if(interview.EMS_Interview_Type__c=='In Person Interview')
    {
        subject = 'Interview Schedule Details';
        body =' Your interview is scheduled for 4/13/2023 10:00 AM - 11:00 AM (UTC)';
        
    }
 
   system.assertEquals('Interview Schedule Details', subject);
    system.assertEquals(' Your interview is scheduled for 4/13/2023 10:00 AM - 11:00 AM (UTC)',body);
   
    
}


      @isTest
static void testSendBulkEmails1() {
    
    EMS_Applicant__c applicant = new EMS_Applicant__c(EMS_Email__c='testcandidate@example.com',EMS_Mobile__c='+918090908090', EMS_Last_Name__c = 'Karim');
    insert applicant;
    
    EMS_Employee__c interviewer = new EMS_Employee__c(Name='Naguru', EMS_Type__c='Full Time', EMS_Work_Email__c='testinterviewer@example.com');
    insert interviewer;
    
    EMS_Position__c position = new EMS_Position__c(Name='Test Position',EMS_Required_Skills__c = 'System Administrator', EMS_Status__c='Active');
    insert position; 
    
    EMS_Job_Opening__c jobopening = new EMS_Job_Opening__c();
    jobopening.EMS_Department__c = 'Finance';
    jobopening.EMS_Experience__c = '1 - 2 Yrs';
     jobopening.EMS_Educational_Requirements__c = 'B.Tech/B.E';
     jobopening.EMS_Minimum_Salary__c = 9000;
    jobopening.EMS_Location__c = 'Hyderabad - Telangana';
    jobopening.EMS_Open_Date__c = Date.today();
     jobopening.Hire_by_Date__c = Date.today();
     jobopening.EMS_Maximum_Salary__c = 70000;
    jobopening.EMS_Job_Title__c = position.Id;
        jobopening.EMS_No_of_Openings__c = 10;
      insert jobopening;
    
    EMS_Job_Applications__c jobApp = new EMS_Job_Applications__c(EMS_Applicant__c=applicant.Id, EMS_Stage__c='Pre-Screening', EMS_Status__c='Passed', EMS_Job_Opening__c=jobopening.Id);
    insert jobApp;
       
       EMS_Employee__c emp = new EMS_Employee__c(Name='Arpit Agarwal', EMS_Type__c='Full Time', EMS_Work_Email__c='test-interviewer@test.com');
       insert emp;
        // Create test data
        EMS_Interview_Scheduling__c interview = new EMS_Interview_Scheduling__c(
            EMS_Interview_Date__c = Date.today().addDays(8),
            EMS_Interview_Start_Time_c__c = DateTime.newInstance(2023,4,20, 10, 30, 9),
            EMS_InterviewEndTime__c = DateTime.newInstance(2023,4,20, 10, 45, 9),
            EMS_Interview_Type__c = 'Virtual Interview',
            EMS_Interviewer_2_Name__c = emp.Id,
            EMS_Interviewer_1_Name__c = emp.Id,
            //EMS_Interviewer_Email__c = emp.EMS_Work_Email__c,
            //EMS_Applicant_Email__c = 'test-applicant@test.com',
            EMS_Interview_Location__c = 'Hyd',
            EMS_Interview_Round__c = 'Technical Round',
            EMS_Interview_Stage__c = 'Scheduled',
            EMS_Interview_Status__c = 'Accepted',
            EMS_Job_Application_ID__c = jobApp.Id,
            RecordTypeId = '012DT000003sALJYA2'
             
        );
        insert interview;    
    Test.startTest();
    
    // Call the method under test with the interview Id
    List<Id> interviewIds = new List<Id>{interview.Id};
    InterviewEmailController.sendBulkEmails(interviewIds);
    Test.stopTest();
    String subject;
    String body;
    if(interview.EMS_Interview_Type__c == 'Virtual Interview')
    {
        subject = 'Interview Schedule Details';
        body ='Virtual Interview';
        
    }
 
   system.assertEquals('Interview Schedule Details', subject);
    system.assertEquals( 'Virtual Interview',body);
}
}