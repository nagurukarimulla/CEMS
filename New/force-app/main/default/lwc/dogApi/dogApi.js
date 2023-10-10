import { LightningElement } from 'lwc';

export default class DogApi extends LightningElement {
    imageReady = false;
    loadingSpinner = false;
    pictureUrl;
    handleClick(){
        this.loadingSpinner = true;
        this.imageReady = false;
        getDogPicture({}).then(resp => {
            this.pictureUrl = JSON.parse(resp).message;
            this.imageReady = true;
            this.loadingSpinner = false;
        })
    }
}