import { LightningElement, wire } from 'lwc';
import SAMPLEMC from "@salesforce/messageChannel/SampleMessageChannel__c"
import {publish, subscribe, MessageContext, APPLICATION_SCOPE, unsubscribe} from 'lightning/messageService';
export default class LmsComponentX extends LightningElement {
    inputValue
    recievedMessage
    subscription
    @wire(MessageContext)
    context

    connectedCallback(){
        this.subscribeMessage()
    }
    subscribeMessage(){
        //subscribe(messageContext, messageChannel, listener, subscriberOptions)
        this.subscription= subscribe(this.context, SAMPLEMC, (message)=>{this.handleMessage(message)}, {scope:APPLICATION_SCOPE})
    }

    handleMessage(message){
        this.recievedMessage = message.lmsData.value? message.lmsData.value :'NO Message published'
    }

    unsubscribeMessage(){
        unsubscribe(this.subscription)
        this.subscription = null
    }

    @wire(MessageContext)
    context

    inputHandler(event){
        this.inputValue = event.target.value
    }

    publishMessage(){
        const message={
            lmsData:{
                value:this.inputValue
            }
        }
        //publish(messageContext, messageChannel, message)
        publish(this.context, SAMPLEMC, message)
    }
    
}