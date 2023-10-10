import { LightningElement,wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import { createMessageContext, releaseMessageContext,publish} from 'lightning/messageService';
import LWCMC from "@salesforce/messageChannel/lwcMessageService__c";
export default class AccountPublisher extends LightningElement {
   context = createMessageContext();
   @wire(getAccounts)
   accounts
   handleClick(event){
    event.preventDefault();
    const message = {
        recordId:event.target.dataset.accId,
        recordData: {value:"Message from lightning web component"}
    };
        publish(this.context,LWCMC,message)
   }
   disconnectedCallback(){
    releaseMessageContext(this.context);
   }
}