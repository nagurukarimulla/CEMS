import { LightningElement, track } from 'lwc';
import makeCallout from '@salesforce/apex/ImageSearch.makeCallout';
export default class CatImageSearch extends LightningElement {
    @track catImages = [];
    limitSize = 2; // Default limit size
  
    handleLimitChange(event) {
      this.limitSize = event.target.value;
    }
  
    handleSearch() {
      makeCallout({ limitSize: this.limitSize })
        .then((result) => {
          this.catImages = result;
        })
        .catch((error) => {
          console.error('Error:', error);
        });
    }
  }
  