import { LightningElement,track} from 'lwc';
import { createMessageContext, releaseMessageContext,APPLICATION_SCOPE,subscribe, unsubscribe } from 'lightning/messageService';
import LWCMC from "@salesforce/messageChannel/lwcMessageService__c";
import NAME_FIELD from '@salesforce/schema/Account.Name';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
export default class AccountSubscriber extends LightningElement {
    context = createMessageContext();
    subscription = null;
    @track receivedMessage = '';
    @track accountId;
    objectApiName='Account';
    fields = [NAME_FIELD, TYPE_FIELD, INDUSTRY_FIELD];
    connectedCallback(){
        this.subscribeMC();
    }
    subscribeMC() {
        if (this.subscription) {
            return;
        }
        this.subscription = subscribe(this.context,LWCMC,(message) => {
            this.handleMessage(message);
        },{scope:APPLICATION_SCOPE});
    }
    handleMessage(message){
        this.accountId = message.recordId;
        this.receivedMessage = message ? message.recordData.value : 'no message payload';
    }   
    disconnectedCallback() {
        releaseMessageContext(this.context);
    }
}