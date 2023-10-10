import { LightningElement } from 'lwc';

export default class P2cParentComponent3 extends LightningElement {
    percentage=10
    changeHandler(event){
        this.percentage = event.target.value
    }
}