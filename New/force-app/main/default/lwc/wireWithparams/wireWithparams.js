import { LightningElement,wire } from 'lwc';
import filterOrigin from '@salesforce/apex/OppController.getCaseList'
export default class WireWithparams extends LightningElement {
    selectedOrigin=''
    @wire(filterOrigin, {Origin:'$selectedOrigin'})
    filteredOrigin

    get originOptions(){
        return [
            {label:"Phone", value:"Phone"},
            {label:"Email", value:"Email"},
            {label:"Web", value:"Web"}
        ]
    }
    originHandler(event){
        this.selectedOrigin = event.target.value
    }
}