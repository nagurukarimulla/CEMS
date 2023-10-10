import { api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

import EMS_INTERVIEW_PANEL_OBJECT from '@salesforce/schema/EMS_Interview_Panel__c';
import EMS_INTERVIEW_PANEL_FIELD from '@salesforce/schema/EMS_Interview_Scheduling__c.EMS_Interview_Panel__c';

const FIELDS = [
    'EMS_Interview_Panel__c.' + EMS_INTERVIEW_PANEL_FIELD.fieldApiName,
    'EMS_Interview_Panel__c.EMS_Interviwer_1__r.EMS_Work_Email__c',
    'EMS_Interview_Panel__c.EMS_Interviwer_2__r.EMS_Work_Email__c',
    'EMS_Interview_Panel__c.EMS_Interviwer_3__r.EMS_Work_Email__c'
];

export default class InterviewPanelFields extends LightningElement {
    @api recordId;
    panelId;
    interviewer1Email;
    interviewer2Email;
    interviewer3Email;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    interviewPanel({ error, data }) {
        if (data) {
            this.panelId = data.fields.EMS_Interview_Panel__c.value;
            this.interviewer1Email = data.fields.EMS_Interview_Panel__c.value.fields.EMS_Interviwer_1__r.value.fields.EMS_Work_Email__c.value;
            this.interviewer2Email = data.fields.EMS_Interview_Panel__c.value.fields.EMS_Interviwer_2__r.value.fields.EMS_Work_Email__c.value;
            this.interviewer3Email = data.fields.EMS_Interview_Panel__c.value.fields.EMS_Interviwer_3__r.value.fields.EMS_Work_Email__c.value;
        } else if (error) {
            console.error(error);
        }
    }

    handlePanelChange(event) {
        this.panelId = event.target.value;
    }

    handleSubmit(event) {
        event.preventDefault();
        const fields = event.detail.fields;
        fields.EMS_Interviewer_1_Work_Email__c = this.interviewer1Email;
        fields.EMS_Interviewer_2_Work_Email__c = this.interviewer2Email;
        fields.EMS_Interviewer_3_Work_Email__c = this.interviewer3Email;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }

    get panelOptions() {
        return {
            objectApiName: EMS_INTERVIEW_PANEL_OBJECT.objectApiName,
            fields: [EMS_INTERVIEW_PANEL_FIELD.fieldApiName],
            filter: 'EMS_Interview_Scheduling__c = \'' + this.recordId + '\''
        };
    }
}