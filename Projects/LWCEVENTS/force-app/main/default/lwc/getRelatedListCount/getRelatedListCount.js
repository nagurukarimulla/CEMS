import { LightningElement,wire,api } from 'lwc';
import {getRelatedListCount} from 'lightning/uiRelatedListApi';

export default class GetRelatedListCount extends LightningElement {
    error;
    responseData;
    @wire(getRelatedListCount, {
        parentRecordId: '0015i00000Wq4QPAAZ',
        relatedListId: 'Contacts'
    })listInfo({ error, data }) {
        if (data) {
            this.responseData = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.responseData = undefined;
        }
    }
}