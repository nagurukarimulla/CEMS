import { LightningElement, wire} from 'lwc';
import { saveAs } from 'file-saver';
import generateXml from '@salesforce/apex/CustomObjectController.generateXml';


export default class GenerateXml1 extends LightningElement {
    @wire(generateXml)
    xmlData;
 
    handleDownload(){
        saveAs(new Blob([this.xmlData], {type: 'text/xml;charset=utf-8'}), 'CustomObject__c.xml');
    }
}