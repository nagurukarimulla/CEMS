import { LightningElement } from 'lwc';
import { createRecord } from "lightning/uiRecordApi";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import RATING_FIELD from "@salesforce/schema/Account.Rating";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class CreateRecord extends LightningElement {
name;
  industry;
  rating;

  handleChange(event) {
    if (event.target.name === "name") {
    
      //this is name input textbox
      this.name = event.target.value;
      console.log(this.name);
    } else if (event.target.name === "industry") {
    
      //this is industry input textbox
      this.industry = event.target.value;
      console.log(this.industry);
    } else if (event.target.name === "rating") {
    
      //this is rating input textbox
      this.rating = event.target.value;
      console.log(this.rating);
    }
  }

  
  handleClick(){
    const fields = {};

    fields[NAME_FIELD.fieldApiName] = this.name;
    fields[INDUSTRY_FIELD.fieldApiName] = this.industry;
    fields[RATING_FIELD.fieldApiName] = this.rating;

    const recordInput = {
        apiName: ACCOUNT_OBJECT.objectApiName,
        fields: fields
      };
      createRecord(recordInput).then(record => {
        console.log(record);
      });
    }
    showToast() {
        const event = new ShowToastEvent({
            title: 'Account',
            message:
                'Created successfully',
        });
        this.dispatchEvent(event);
    }
  }