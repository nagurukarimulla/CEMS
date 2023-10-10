import { LightningElement, track } from 'lwc';

export default class Calculator extends LightningElement {
@track displayValue = '0';
@track firstOperand = null;
@track secondOperand = null;
@track operator = null;
@track isResultDisplayed = false;
handleNumber(event) {
    const value = event.target.label;
    if(this.isResultDisplayed) {
        this.displayValue = '0';
        this.isResultDisplayed = false;
    }
    if(this.displayValue === '0') {
        this.displayValue = value;
    } else {
        this.displayValue += value;
    }
}

handleDecimal() {
    if(this.isResultDisplayed) {
        this.displayValue = '0.';
        this.isResultDisplayed = false;
    }
    if(this.displayValue.indexOf('.') === -1) {
        this.displayValue += '.';
    }
}

handleClear() {
    this.displayValue = '0';
    this.firstOperand = null;
    this.secondOperand = null;
    this.operator = null;
    this.isResultDisplayed = false;
}

handleSign() {
    this.displayValue = String(-this.displayValue);
}

handlePercentage() {
    this.displayValue = String(this.displayValue / 100);
}

handleOperator(event) {
    if(this.firstOperand === null) {
        this.firstOperand = Number(this.displayValue);
    } else {
        this.secondOperand = Number(this.displayValue);
        this.calculateResult();
    }
    this.operator = event.target.label;
    this.isResultDisplayed = true;
}

calculateResult() {
    switch(this.operator) {
        case '÷':
            this.displayValue = String(this.firstOperand / this.secondOperand);
            break;
        case '×':
            this.displayValue = String(this.firstOperand * this.secondOperand);
            break;
        case '-':
            this.displayValue = String(this.firstOperand - this.secondOperand);
            break;
        case '+':
            this.displayValue = String(this.firstOperand + this.secondOperand);
            break;
        default:
            break;
    }
    this.firstOperand = Number(this.displayValue);
    this.secondOperand = null;
}

handleEqual() {
    this.secondOperand = Number(this.displayValue);
    this.calculateResult();
    this.isResultDisplayed = true;
}
}