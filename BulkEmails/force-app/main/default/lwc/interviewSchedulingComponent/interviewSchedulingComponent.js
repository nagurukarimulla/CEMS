
import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import sendBulkEmails from '@salesforce/apex/InterviewEmailController.sendBulkEmails';
import getInterviewRecords from '@salesforce/apex/InterviewEmailController.getInterviewRecords';

export default class InterviewSchedulingComponent extends LightningElement {
    @api title
    @api selectedRecords = [];
    @track records = [];
    
    @track columns = [
        { label: 'Candidate Name', fieldName: 'EMS_Candidate_Name__c', type: 'text' },
        { label: 'Interview Type', fieldName: 'EMS_Interview_Type__c', type: 'text' },
        { label: 'Interview Status', fieldName: 'EMS_Interview_Status__c', type: 'picklist' },
        { label: 'Candidate Email', fieldName: 'EMS_Applicant_Email__c', type: 'email' },
        { label: 'Interview Round', fieldName: 'EMS_Interview_Round__c', type: 'picklist' },
        
    ];

    // Fetches the interview records from the server
    connectedCallback() {
        this.getInterviewRecords();
        this.title = 'Send Bulk Interview Emails';
    }

    // Handles the selection of interview records
    handleRowSelection(event) {
        this.selectedRecords = event.detail.selectedRows;
    }
          // Handles the search term change event
          handleSearchTermChange(event) {
            this.searchTerm = event.target.value;
            this.getInterviewRecords();
        }

   // Fetches the interview records from the server
getInterviewRecords() {
    getInterviewRecords()
        .then(result => {
            // Filter the records based on the search term
            if (this.searchTerm) {
                const regex = new RegExp(this.searchTerm, "i");
                this.records = result.filter(record =>
                    regex.test(record.EMS_Candidate_Name__c) ||
        
                    regex.test(record.EMS_Applicant_Email__c)   
                );
            } else {
                this.records = result.filter(record => record.EMS_Interview_Status__c === 'Accepted');
            }
        })
        .catch(error => {
            console.error(error);
        });
}
    //Sending bulk emails
    sendBulkEmails() {
        console.log('records ' + JSON.stringify(this.selectedRecords));
        const interviewIds = this.selectedRecords.map(record => record.Id);
        console.log(JSON.stringify('Interview Ids List :' + interviewIds));
        if (interviewIds.length > 0) {
            sendBulkEmails({ interviewIds })
            
    .then(result => {
        console.log('result: '+ JSON.stringify(result));
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Emails sent successfully',
                variant: 'success'
            })
        );
    })
    .catch(error => {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: error.body.message,
                variant: 'error'
            })
        );
    });    
}else {
    this.dispatchEvent(
        new ShowToastEvent({
            title: 'Error',
            message: 'Please select at least one interview record to send emails.',
            variant: 'error'
        })
    );
}
    }
}

