import { LightningElement } from 'lwc';
import generateXMLFile from '@salesforce/apex/GenerateXML.generateXMLFile';

export default class GenerateXml extends LightningElement {
    xmlFile;
        generateXML() {
            generateXMLFile()
                .then(result => {
                    this.xmlFile = result;
                    console.log(this.xmlFile);

                })
                .catch(error => {
                    console.error(error);
                });
        }
        
    }
