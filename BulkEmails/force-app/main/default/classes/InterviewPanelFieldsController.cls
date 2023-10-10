public with sharing class InterviewPanelFieldsController {
    
    // Other Apex methods...

    @AuraEnabled(cacheable=true)
    public static List<EMS_Employee__c> getInterviewersByPanel(Id panelId) {
        List<EMS_Employee__c> interviewers = new List<EMS_Employee__c>();
        try {
            EMS_Interview_Panel__c panel = [SELECT EMS_Interviewer_1__r.EMS_Work_Email__c,
                                                  EMS_Interviewer_2__r.EMS_Work_Email__c,
                                                  EMS_Interviewer_3__r.EMS_Work_Email__c
                                           FROM EMS_Interview_Panel__c
                                           WHERE Id = :panelId];
            interviewers.add(panel.EMS_Interviewer_1__r);
            interviewers.add(panel.EMS_Interviewer_2__r);
            interviewers.add(panel.EMS_Interviewer_3__r);
        } catch(Exception ex) {
            System.debug('Exception occurred while fetching interviewers for panel Id ' + panelId + ': ' + ex.getMessage());
        }
        return interviewers;
    }

    // Other Apex methods...
}
