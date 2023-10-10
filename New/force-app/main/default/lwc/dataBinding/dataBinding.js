import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {
    greeting = 'Karim';

    handleChange1(event) {
        this.greeting = event.target.value;
    }

    age = 28;

    handleChange2(event) {
        this.age = event.target.value;
    }

    gf = 'Muntaj';

    handleChange3(event) {
        this.gf = event.target.value;
    }
}