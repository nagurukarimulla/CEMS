import { LightningElement,track } from 'lwc';
import { createMetadataClient } from 'lightning/platformMetadataService';
import js2xmlparser from 'js2xmlparser';

export default class XML extends LightningElement {
    @track objectName = '';

    handleObjectNameChange(event) {
        this.objectName = event.target.value;
    }

    async handleGenerateXmlClick() {
        const metadataClient = await createMetadataClient();
        const result = await metadataClient.readMetadata('CustomObject', [this.objectName]);
        const xmlData = js2xmlparser.parse('CustomObject', result[0]);
        const fileData = `data:text/xml;charset=utf-8,${encodeURIComponent(xmlData)}`;
        const downloadLink = document.createElement('a');
        downloadLink.href = fileData;
        downloadLink.download = `${this.objectName}.object`;
        downloadLink.click();
    }
}