import { LightningElement,wire } from 'lwc';
import getOppList from '@salesforce/apex/OppController.getOpportunitiesList'
export default class WireLWC extends LightningElement {
    opptList
    
    @wire(getOppList)

    opptList

   

}