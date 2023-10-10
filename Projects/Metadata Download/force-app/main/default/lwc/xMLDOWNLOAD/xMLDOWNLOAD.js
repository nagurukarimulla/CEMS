import { LightningElement } from 'lwc';
import  createMetadataClient  from 'lightning/platformMetadataService';
import js2xmlparser from 'js2xmlparser';

export default class XMLDOWNLOAD extends LightningElement {
    async handleDownloadXmlClick() {
        const objectName = 'CustomObject__c'; // Replace with the custom object name
        const metadataClient = await createMetadataClient();
        const result = await metadataClient.readMetadata('CustomObject', [objectName]);
        const xmlData = js2xmlparser.parse('CustomObject', result[0]);
        const fileData = `data:text/xml;charset=utf-8,${encodeURIComponent(xmlData)}`;
        const downloadLink = document.createElement('a');
        downloadLink.href = fileData;
        downloadLink.download = `${objectName}.object`;
        downloadLink.click();
    }
}