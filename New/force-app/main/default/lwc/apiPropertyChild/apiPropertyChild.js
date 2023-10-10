import { LightningElement,api } from 'lwc';

export default class ApiPropertyChild extends LightningElement {
    @api percentage;

    get style() {
        return `width: ${this.percentage}%`;
    }
}