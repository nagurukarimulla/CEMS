import {  track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import EMS_INTERVIEW_FEEDBACK_OBJECT from '@salesforce/schema/EMS_Feedback__c';
//import EMS_INTERVIEW_FIELD from '@salesforce/schema/EMS_Feedback__c.EMS_Interview__c';
import SKILL_1_FIELD from '@salesforce/schema/EMS_Feedback__c.EMS_Skill1__c';
import SKILL_2_FIELD from '@salesforce/schema/EMS_Feedback__c.Skill2__c';
import SKILL_3_FIELD from '@salesforce/schema/EMS_Feedback__c.Skill3__c';
import SKILL_4_FIELD from '@salesforce/schema/EMS_Feedback__c.Skill4__c';
import SKILL_5_FIELD from '@salesforce/schema/EMS_Feedback__c.Skill5__c';
import OVERALL_RATING_FIELD from '@salesforce/schema/EMS_Feedback__c.EMS_Technical_Skills_Overall_Rating__c';

export default class SkillRating extends LightningElement {
    @track skills = [
        { id: 1, name: 'Skill 1', rating: 1, comment: '' },
        { id: 2, name: 'Skill 2', rating: 1, comment: '' },
        { id: 3, name: 'Skill 3', rating: 1, comment: '' },
        { id: 4, name: 'Skill 4', rating: 1, comment: '' },
        { id: 5, name: 'Skill 5', rating: 1, comment: '' }
    ];

    get overallRating() {
        const total = this.skills.reduce((acc, skill) => acc + skill.rating, 0);
        return (total / this.skills.length).toFixed(2);
    }

    handleRatingChange(event) {
        const id = event.target.dataset.id;
        const rating = parseInt(event.target.value);
        const skill = this.skills.find(skill => skill.id === id);
        skill.rating = rating;
    }

    handleCommentChange(event) {
        const id = event.target.dataset.id;
        const comment = event.target.value;
        const skill = this.skills.find(skill => skill.id === id);
        skill.comment = comment;
    }

    async handleSaveFeedback() {
        const fields = {};
        fields[EMS_INTERVIEW_FIELD.fieldApiName] = 'a0C1R00000B5JL7UAN'; // Replace with the actual interview record Id
        fields[SKILL_1_FIELD.fieldApiName] = this.skills.find(skill => skill.id === 1).rating;
        fields[SKILL_2_FIELD.fieldApiName] = this.skills.find(skill => skill.id === 2).rating;
        fields[SKILL_3_FIELD.fieldApiName] = this.skills.find(skill => skill.id === 3).rating;
        fields[SKILL_4_FIELD.fieldApiName] = this.skills.find(skill => skill.id === 4).rating;
        fields[SKILL_5_FIELD.fieldApiName] = this.skills.find(skill => skill.id === 5).rating;
        fields[OVERALL_RATING_FIELD.fieldApiName] = this.overallRating;

        const recordInput = { apiName: EMS_INTERVIEW_FEEDBACK_OBJECT.objectApiName, fields };
        try {
            const record = await createRecord(recordInput);
            console.log('Feedback record created: ', record.id);
        } catch (error) {
            console.error('Error creating feedback record: ', error);
        }
    }
}