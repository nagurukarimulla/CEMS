import { LightningElement,wire } from 'lwc';
import getAccountData from '@salesforce/apex/custController.getXmlData';

export default class Metadata extends LightningElement {
    customObject;
    @wire(getAccountData)
    wiredAccountData({ error, data }) {
        if (data) {
            this.customObject = JSON.stringify(data);
            console.log(JSON.stringify(data));
        } else if (error) {
            console.log(error);
        }
    }
    generateXML() {
        // Get the custom object data
       /* const customObject = {
             name: 'John Doe', 
             age: 30,
             gender: 'Male' 
            };*/
           
        // Create the XML document
        const xmlSerializer = new XMLSerializer();
        const xmlString = xmlSerializer.serializeToString(this.toXml(customObject));
    
        // Download the XML file
        const element = document.createElement('a');
        element.setAttribute('href', 'data:text/xml;charset=utf-8,' + encodeURIComponent(xmlString));
        element.setAttribute('download', 'myCustomObject.xml');
        element.style.display = 'none';
        document.body.appendChild(element);
        element.click();
        document.body.removeChild(element);
      }
    
      toXml(obj) {
        const doc = document.implementation.createDocument(null, null, null);
        const root = doc.createElement('CustomObject');
        for (const [key, value] of Object.entries(obj)) {
          const element = doc.createElement(key);
          element.textContent = value;
          root.appendChild(element);
        }
        doc.appendChild(root);
        return doc;
      }
    }