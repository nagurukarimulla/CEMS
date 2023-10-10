import { LightningElement, track, wire, api } from 'lwc';
import authenticateUser from '@salesforce/apex/SalesforceCalloutController.authenticateUser';
import callout from '@salesforce/apex/SalesforceCalloutController.callout';
import myStyle from './loginForm.css';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getObjectInfos } from 'lightning/uiObjectInfoApi';
import { invoke } from '@salesforce/apex';
import getObjectList from '@salesforce/apex/MyController.getObjectList';
//import { getPicklistValues, getDescribe } from '@salesforce/schema';
import getObjectMetadata from '@salesforce/apex/ObjectMetadataController.getObjectMetadata';
import getObjectFields from '@salesforce/apex/ObjectMetadataController.getObjectFields';

export default class LoginForm extends LightningElement {
    @track username;
    @track password;
    @track securityToken;
    @track endpointUrl;
    @track isLoggedIn = false;
    

    handleUsernameInput(event) {
        this.username = event.target.value;
    }

    handlePasswordInput(event) {
        this.password = event.target.value;
    }

    handleSecurityTokenInput(event) {
        this.securityToken = event.target.value;
    }

    handleEndpointUrlInput(event) {
        this.endpointUrl = event.target.value;
    }

    handleSubmit(event) {
        event.preventDefault();
        authenticateUser({username: this.username, password: this.password, securityToken: this.securityToken, endpointUrl: this.endpointUrl})
            .then(result => {
                if (result === 'success') {
                    this.isLoggedIn = true;
                    this.dispatchEvent(new CustomEvent('authsuccess'));
                } else {
                    alert('Authentication failed. Please try again.');
                }
            })
            .catch(error => {
                alert('Authentication failed. Please try again.');
                console.error(error);
            });
    }

    objectOptions = [];
    fieldOptions = [];
    selectedObject = '';
    selectedFields = [];

    @wire(getObjectMetadata)
    wiredObjectMetadata({ error, data }) {
        if (data) {
            this.objectOptions = Object.keys(data).map(key => ({ label: key, value: key }));
        } else if (error) {
            console.error(error);
        }
    }

    handleObjectChange(event) {
        const objectName = event.target.value;
        this.selectedObject = objectName;
        getObjectFields({ objectName })
            .then(data => {
                this.fieldOptions = data.map(field => ({ label: field, value: field }));
            })
            .catch(error => {
                console.error(error);
            });
    }

    handleFieldChange(event) {
        this.selectedFields = event.detail.value;
    }
    /*
    selectedObject = '';
    objectList = [];
    fieldList = [];
    selectedFields = [];

    @wire(getObjectList)
    wiredObjects({ error, data }) {
        if (data) {
            this.objectList = data.map(objectType => {
                return {
                    label: objectType.label,
                    value: objectType.name
                };
            });
        } else if (error) {
            console.error(error);
        }
    }

    @wire(getObjectInfo, { objectApiName: '$selectedObject' })
    objectInfo({ error, data }) {
        if (data) {
            const fields = Object.values(data.fields)
                .filter(field => !field.deprecatedAndHidden)
                .map(field => {
                    return {
                        label: field.label,
                        value: field.apiName
                    };
                });
            this.fieldList = fields;
        } else if (error) {
            console.error(error);
        }
    }

    handleObjectChange(event) {
        this.selectedObject = event.detail.value;
    }

    handleFieldChange(event) {
        this.selectedFields = event.detail.value;
    }
    getData() {
        console.log('Selected Fields:', this.selectedFields);
        // Add your logic here to retrieve data based on the selected object and fields
        /*if (!this.selectedObject || this.selectedFields.length === 0) {
        console.log('Please select an object and at least one field');
        return;
    }

    let fields = this.selectedFields.join(',');
    let queryString = `SELECT ${fields} FROM ${this.selectedObject}`;

    retrieveData({ query: queryString })
        .then(result => {
            this.data = result;
            console.log('Retrieved data:', this.data);
        })
        .catch(error => {
            console.error('Error retrieving data:', error);
      
        });*/
        /*
    }

    get isLoggedIn() {
        // Implement this based on your authentication logic
        return true;
    }*/
}
    /*
    @track objectList = [];

    selectedObjectApiName;
    objectOptions;
    fieldOptions = [];
    selectedFields = [];
    queryResult;
    recordInput = {
        apiName: '',
        fields: {}
    };
    fileReader;
    fileContent;
    fileFields = [];
    showSpinner = false;

    @wire(getObjectInfo, { objectApiName: '$selectedObjectApiName' })
    objectInfo({ error, data }) {
        if (data) {
            this.fieldOptions = Object.keys(data.fields).map(fieldName => {
                return {
                    label: data.fields[fieldName].label,
                    value: fieldName
                };
            });
        } else if (error) {
            console.log(error);
        }
    }

    @wire(getObjectInfo)
    objectList({ error, data }) {
        if (data) {
            this.objectOptions = Object.keys(data).map(objectApiName => {
                return {
                    label: data[objectApiName].label,
                    value: objectApiName
                };
            });
        } else if (error) {
            console.log(error);
        }
    }

    handleObjectSelection(event) {
        this.selectedObjectApiName = event.target.value;
        this.selectedFields = [];
    }

    handleFieldSelection(event) {
        this.selectedFields = event.target.value;
    }

    handleQuery() {
        let fields = this.selectedFields.join(',');
        let queryString = `SELECT ${fields} FROM ${this.selectedObjectApiName}`;
        this.showSpinner = true;
        query(queryString)
            .then(result => {
                this.queryResult = result.records;
                this.showSpinner = false;
            })
            .catch(error => {
                console.log(error);
                this.showSpinner = false;
            });
    }

    handleInsert() {
        if (!this.fileContent) {
            this.showToast('Error', 'Please select a file to insert', 'error');
            return;
        }

        let records = this.parseCSV(this.fileContent);
        let recordInputs = records.map(record => {
            return {
                apiName: this.selectedObjectApiName,
                fields: record
            };
        });

        this.showSpinner = true;
        insertRecord(recordInputs)
            .then(result => {
                this.showToast('Success', 'Records inserted successfully', 'success');
                this.showSpinner = false;
            })
            .catch(error => {
                console.log(error);
                this.showToast('Error', error.body.message, 'error');
                this.showSpinner = false;
            });
    }

    handleUpdate() {
        if (!this.fileContent) {
            this.showToast('Error', 'Please select a file to update', 'error');
            return;
        }

        let records = this.parseCSV(this.fileContent);
        let recordUpdates = records.map(record => {
            let recordId = record.Id;
            delete record.Id;
            return {
                fields: record,
                id: recordId
            };
        });

        this.showSpinner = true;
        updateRecord(recordUpdates)
            .then(result => {
                this.showToast('Success', 'Records updated successfully', 'success');
                this.showSpinner = false;
            })
            .catch(error => {
                console.log(error);
                this.showToast('Error', error.body.message, 'error');
                this.showSpinner = false;
            });
    }*/

    /*
    selectedObject = '';
    objectList = [];
    fieldList = [];
    selectedFields = [];

    @wire(getObjectInfo, { objectApiName: '$selectedObject' })
    objectInfo({ error, data }) {
        if (data) {
            const fields = Object.values(data.fields)
                .filter(field => !field.deprecatedAndHidden)
                .map(field => {
                    return {
                        label: field.label,
                        value: field.apiName
                    };
                });
            this.fieldList = fields;
        } else if (error) {
            console.error(error);
        }
    }

    @wire(getObjectList)
    wiredObjects({ error, data }) {
        if (data) {
            this.objectList = data.map(objectType => {
                const objectDescribe = objectType.getDescribe();
                return {
                    label: objectDescribe.label,
                    value: objectDescribe.name
                };
            });
        } else if (error) {
            console.error(error);
        }
    }

    handleObjectChange(event) {
        this.selectedObject = event.detail.value;
    }

    handleFieldChange(event) {
        this.selectedFields = event.detail.value;
    }

    getData() {
        console.log('Selected Fields:', this.selectedFields);
        // Add your logic here to retrieve data based on the selected object and fields
    }

    get isLoggedIn() {
        // Implement this based on your authentication logic
        return true;
    }
}*/