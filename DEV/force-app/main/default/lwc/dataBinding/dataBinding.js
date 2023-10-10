import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {
    greeting = 'Jason';

    handleChange1(event) {
        this.greeting = event.target.value;
    }

    age = 25;

    handleChange2(event) {
        this.age = event.target.value;
    }

    gf = 'Alexa';

    handleChange3(event) {
        this.gf = event.target.value;
    }
}