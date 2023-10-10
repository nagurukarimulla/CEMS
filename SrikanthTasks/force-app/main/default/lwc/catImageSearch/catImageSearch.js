import { LightningElement, wire, api } from 'lwc';
import CatImages from '@salesforce/apex/CatUrl.CatImages';

export default class ImageGrid extends LightningElement {
    @api size;
    size = 'large';
    imageUrls;
    sizeOptions = [
        { label: 'Small', value: 'small' },
        { label: 'Large', value: 'large' }
    ];

    connectedCallback() {
        this.fetchImage();
    }
  
    

    fetchImage() {
        CatImages()
            .then((result) => {
                console.log(result);
                this.imageUrls = result; // Assuming the first URL in the list is the one you want to display
            })
            .catch((error) => {
                // Handle error
                console.error(error);
            });

    }
    get getSizeClass() {
        return this.size === 'large' ? 'image-large' : 'image-small';
    }
    handleSizeChange(event) {
        this.size = event.detail.value;
    }

}
