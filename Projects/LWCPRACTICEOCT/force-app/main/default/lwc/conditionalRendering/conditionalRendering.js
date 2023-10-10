import { LightningElement } from 'lwc';

export default class helloConditionalRendering extends LightningElement {
    isVisible = false
    name
    handleClick(){
        this.isVisible = true
    }

    changeHandler(event){
        this.name = event.target.value
    }

    get adminMethod(){
        return this.name === 'admin'    
    }

}   