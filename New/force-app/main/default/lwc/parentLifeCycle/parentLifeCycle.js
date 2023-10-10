import { LightningElement } from 'lwc';

export default class ParentLifeCycle extends LightningElement {
    isChildVisible = false
    constructor(){ 
        super()
        console.log("======parent constructor called=======")
    }
    connectedCallback(){ 
        console.log("========parent connectedCallback called======")
    }
    renderedCallback(){ 
        console.log("=======parent renderedCallback called========")
    }

    name
    changeHandler(event){
        this.name = event.target.value
    }
}