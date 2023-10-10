import { LightningElement } from 'lwc';

export default class LwcConditionalDirectives extends LightningElement {
    showText = false
    get getLabel(){
        return this.showText ? 'Hide text' : 'Show Text'
    }
    showTextHandler(){
        this.showText = !this.showText
    }

    /****Getter demo */
    
    company = 'CittaCore'
    newcompany = 'Rutranics'
    get isCompanyCittaCore(){
        console.log("isCompanyCittaCore getter called")
        return this.company === "CittaCore"
    }
    get isCompanyJNET(){
        console.log("isCompanyJNET getter called")
        return this.newcompany === "JNET"
    }
    get isCompanyRutranics(){
        console.log("isCompanyRutranics getter called")
        return this.newcompany === "Rutranics"
    }

    
    changeHandler(event){
        this.company = event.target.value
    }
    changeHandler1(event){
        this.newcompany = event.target.value
    }
    
}