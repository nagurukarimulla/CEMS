import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class DynamicRecordCreationRows extends NavigationMixin(LightningElement) {

    keyIndex = 0;
    @track itemList = [
        {
            id: 0
        }
    ];

    addRow() {
        ++this.keyIndex;
        var newItem = [{ id: this.keyIndex }];
        this.itemList = this.itemList.concat(newItem);
    }

    removeRow(event) {
        if (this.itemList.length >= 2) {
            this.itemList = this.itemList.filter(function (element) {
                return parseInt(element.id) !== parseInt(event.target.accessKey);
            });
        }
    }

    handleSubmit() {
        var isVal = true;
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            isVal = isVal && element.reportValidity();
        });
        if (isVal) {
            this.template.querySelectorAll('lightning-record-edit-form').forEach(element => {
                element.submit();
            });
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Property successfully created',
                    variant: 'success',
                }),
            );
            // Navigate to the Account home page
            this[NavigationMixin.Navigate]({
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: 'Add_property_Details__c',
                    actionName: 'home',
                },
            });
        } else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: 'Please enter all the required fields',
                    variant: 'error',
                }),
            );
        }
    }
    handleClear(){
        this.template.querySelector('lightning-layout-item').reset();
    }

}