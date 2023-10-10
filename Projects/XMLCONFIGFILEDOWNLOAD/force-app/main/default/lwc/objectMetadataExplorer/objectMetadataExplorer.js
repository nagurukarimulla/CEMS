import { LightningElement, wire } from 'lwc';
import getObjectMetadata from '@salesforce/apex/ObjectMetadataController.getObjectMetadata';
import getObjectFields from '@salesforce/apex/ObjectMetadataController.getObjectFields';

export default class ObjectList extends LightningElement {
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
}
