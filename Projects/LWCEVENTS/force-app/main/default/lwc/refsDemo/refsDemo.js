import { LightningElement } from 'lwc';

export default class RefsDemo extends LightningElement {
    submitHandler(){
        console.log("this.refs.nameRef", this.refs.nameRef)
        const nameVal = this.refs.nameRef.value
        const phoneNum = this.refs.phoneRef.value
    //     If the template contains duplicate lwc:ref directives, 
    // this.refs references the last directive.
        console.log(nameVal)
        console.log(phoneNum)

        this.refs.responseRef.innerHTML = `<p>Submitted Name is ${nameVal} and Phone is ${phoneNum}</p>`
    }

    //this.template.querySelector('.hello') vs refs
}