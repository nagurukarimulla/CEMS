Global class StudentQueueable implements System.Queueable {
    School__c schoolRec;
    public StudentQueueable(School__c sr){
        schoolRec = sr;
    }
    Global void Execute(System.QueueableContext qc){ 
        Student__c stuRecord = new Student__c();
        stuRecord.Student_Name__c = 'Karim';
        stuRecord.Class_Enrolled__c = 17;
        stuRecord.Address__c = schoolRec.School_Address__c;
        stuRecord.Email__c = schoolRec.School_Email__c;
        stuRecord.Phone_Number__c = '8712314388';
        stuRecord.School__c = schoolRec.Id;
        insert stuRecord;
        if(stuRecord.Id != null){
            System.debug('Student record id:---'+stuRecord.Id);
        }
    }

}