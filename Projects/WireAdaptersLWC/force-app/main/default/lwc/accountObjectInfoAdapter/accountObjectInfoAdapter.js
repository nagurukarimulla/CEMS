import { LightningElement, wire} from 'lwc';
import {getObjectInfo} from 'lightning/uiObjectInfoApi'
import ACCOUNT_OBJECT from '@salesforce/schema/Account'

export default class AccountObjectInfoAdapter extends LightningElement {
    @wire(getObjectInfo, {objectApiName:ACCOUNT_OBJECT})
    objectInfo
}