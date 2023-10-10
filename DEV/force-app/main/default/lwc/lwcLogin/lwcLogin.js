import { LightningElement, wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const objectApiName = 'User';
const fields = ['Username', 'Password__c', 'Security_Token__c'];

export default class SalesforceLogin extends LightningElement {
    username;
    password;
    securityToken;

    handleUsernameChange(event) {
        this.username = event.target.value;
    }

    handlePasswordChange(event) {
        this.password = event.target.value;
    }

    handleSecurityTokenChange(event) {
        this.securityToken = event.target.value;
    }

    @wire(createRecord, { objectApiName, fields })
    createUser({ error, data }) {
        if (data) {
            // Show a success toast message
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'User created',
                    variant: 'success'
                })
            );
        } else if (error) {
            // Show an error toast message
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating user',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }
    }

    handleLogin() {
        // Code to authenticate the user and log them in to Salesforce
        const fields = {
            'Username': this.username,
            'Password__c': this.password,
            'Security_Token__c': this.securityToken
        };
        this.createUser({ fields });
    }
}