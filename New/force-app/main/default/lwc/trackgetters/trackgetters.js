import { LightningElement,track } from 'lwc';

export default class trackgetters extends LightningElement {
    /***Data binding example */
    fullname="Salesforce Certified Platform Developer I" 
    title ="LWC"
    changeHandler(event){
        this.title = event.target.value
    }

    /***@track binding example */    
        
   @track address={
        city:'Hyderabad',
        postcode:500032,
        country:'India'
    }
    trackHandler(event){
        this.address.city = event.target.value
    }

    /***getter example */
    users = ["Karim", "PRADEEP", "Pavan"]
    num1 = 50
    num2 = 7
    // this.firstUser =this.users[0]
    get firstUser(){
        return this.users[0].toUpperCase()
    }
    get secondUser(){
        return this.users[1].toLowerCase()
    }
    get thirdUser(){
        return this.users[2]
    }

    get multiply(){
        return this.num1*this.num2
    }

}