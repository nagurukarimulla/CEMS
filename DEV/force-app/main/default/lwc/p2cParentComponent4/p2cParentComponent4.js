import { LightningElement, api } from 'lwc';

export default class P2cParentComponent4 extends LightningElement {
    handleClick(){
        this.template.querySelector('c-p2c-slider-component').resetSlider()
    }
}