import { LightningElement,track } from 'lwc';
import getMetadata from '@salesforce/apex/PackageClass.getMetadata';
export default class XMLGenerator extends LightningElement {
 
       @track xmlString;
        isboolean=false;
        handleClick() {
            getMetadata()
                .then(result => {
                    this.isboolean=!this.isboolean;
                    if(this.isboolean===true){
                    this.xmlString = result;
                    }
                })
                .catch(error => {
                    console.error(error);
                });
        }

        downloadFile() {
            getMetadata()
                .then(result => {
                    this.isboolean=!this.isboolean;
                    if(this.isboolean===true){
                    this.xmlString = result;
                    }
                    const element = document.createElement('a');
                    element.setAttribute('href', 'data:text/xml;charset=utf-8,' + encodeURIComponent(result));
                    element.setAttribute('download', 'package.xml');
                    element.style.display = 'none';
                    document.body.appendChild(element);
                    element.click();
                    document.body.removeChild(element);
                    
                })
                .catch(error => {
                    console.error(error);
                });
        }

    }