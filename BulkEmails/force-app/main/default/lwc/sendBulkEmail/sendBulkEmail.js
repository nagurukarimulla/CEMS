import { LightningElement, track, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getInterviews from '@salesforce/apex/InterviewController.getInterviews';
import updateInterviewType from '@salesforce/apex/InterviewController.updateInterviewType';
import sendBulkEmail from '@salesforce/apex/InterviewController.sendBulkEmail';

const columns = [
    { label: 'EMS Candidate Name', fieldName: 'EMS_Candidate_Name__c' },
    { label: 'Interview Date', fieldName: 'EMS_Interview_Date__c', type: 'date' },
    { label: 'Interview Time', fieldName: 'EMS_Interview_Start_Time__c', type: 'time', sortable: true },
    { label: 'Interview Type', fieldName: 'EMS_Interview_Type__c', sortable: true },
    { label: 'Interviewer Name', fieldName: 'EMS_Interviewer_Name__c' },
    { label: 'Interview Status', fieldName: 'EMS_Interview_Status__c' },
    { label: 'Applicant Email', fieldName: 'EMS_Applicant_Email__c' }
];

export default class SendBulkEmail extends LightningElement {
    @track interviews = [];
    @track selectedRows = [];
    @track showModal = false;
    @track showLinkInput = false;
    @track showLocationInput = false;
    @track showDeclineReasonInput = false;
    @track showTypeDropdown = false;
    @track typeOptions = [
        { label: 'Phone', value: 'Phone' },
        { label: 'Video', value: 'Video' },
        { label: 'In-person', value: 'In-person' }
    ];
    @track sortBy;
    @track sortDirection;
    @track searchKeyword = '';
    @track showTable = false;

    wiredInterviewsResult;

    @wire(getInterviews, { searchKeyword: '$searchKeyword' })
    wiredInterviews(result) {
        this.wiredInterviewsResult = result;
        if (result.data) {
            this.interviews = result.data;
            this.showTable = true;
        } else if (result.error) {
            this.showToast('Error', 'An error occurred while fetching interviews.', 'error');
            this.showTable = false;
        }
    }

    get options() {
        return [
            { label: 'Phone', value: 'Phone' },
            { label: 'Video', value: 'Video' },
            { label: 'In-person', value: 'In-person' }
        ];
    }

    handleRowSelection(event) {
        this.selectedRows = event.detail.selectedRows;
        this.showModal = this.selectedRows.length > 0;
    }

    handleSearch(event) {
        this.searchKeyword = event.target.value;
    }

    handleSort(event) {
        this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
    }

    handleLinkChange(event) {
        const interviewId = this.selectedRows[0].Id;
        const updatedInterview = this.interviews.find(interview => interview.Id === interviewId);
        updatedInterview.EMS_Meeting_Link__c = event.target.value;
    }

    handleLocationChange(event) {
        const interviewId = this.selectedRows[0].Id;
        const updatedInterview = this.interviews.find(interview => interview.Id === interviewId);
        updatedInterview.EMS_Interview_Location__c = event.target.value;
    }

    handleDeclineReasonChange(event) {
        const interviewId = this.selectedRows[this.selectedIndex].Id;
        const value = event.target.value;
        const interviews = JSON.parse(JSON.stringify(this.interviews));
        const index = interviews.findIndex(interview => interview.Id === interviewId);
        interviews[index].EMS_Decline_Reason__c = value;
        this.interviews = interviews;
        }
        handleTypeChange(event) {
            const interviewId = this.selectedRows[this.selectedIndex].Id;
            const value = event.target.value;
            const interviews = JSON.parse(JSON.stringify(this.interviews));
            const index = interviews.findIndex(interview => interview.Id === interviewId);
            interviews[index].EMS_Interview_Type__c = value;
            this.interviews = interviews;
        }
        
        handleUpdateType() {
            this.showModal = false;
            this.showTable = true;
            this.showTypeDropdown = false;
            const interviewsToUpdate = JSON.parse(JSON.stringify(this.selectedRows));
            interviewsToUpdate.forEach(interview => {
                delete interview.attributes;
                delete interview.Id;
            });
        
            sendBulkEmail({
                interviews: interviewsToUpdate
            })
            .then(result => {
                console.log(result);
                const successToast = new ShowToastEvent({
                    title: 'Success',
                    message: 'Interview types updated successfully',
                    variant: 'success'
                });
                this.dispatchEvent(successToast);
            })
            .catch(error => {
                console.error(error);
                const errorToast = new ShowToastEvent({
                    title: 'Error',
                    message: 'An error occurred while updating interview types',
                    variant: 'error'
                });
                this.dispatchEvent(errorToast);
            });
        }
        
        handleSendEmail() {
            this.showModal = false;
            this.showTable = true;
            const interviewsToSend = JSON.parse(JSON.stringify(this.selectedRows));
            interviewsToSend.forEach(interview => {
                delete interview.attributes;
                delete interview.Id;
            });
        
            sendBulkEmail({
                interviews: interviewsToSend
            })
            .then(result => {
                console.log(result);
                const successToast = new ShowToastEvent({
                    title: 'Success',
                    message: 'Bulk email sent successfully',
                    variant: 'success'
                });
                this.dispatchEvent(successToast);
            })
            .catch(error => {
                console.error(error);
                const errorToast = new ShowToastEvent({
                    title: 'Error',
                    message: 'An error occurred while sending bulk email',
                    variant: 'error'
                });
                this.dispatchEvent(errorToast);
            });
        }
    }        
