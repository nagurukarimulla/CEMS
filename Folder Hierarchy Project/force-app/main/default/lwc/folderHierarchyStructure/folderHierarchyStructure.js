import { LightningElement, wire, api } from 'lwc';
import FolderHierarchy from '@salesforce/apex/FolderHierarchy.getEmployeeFolderStructure'
import getFileStructure from '@salesforce/apex/FolderHierarchy.getFileStructure'

export default class FolderHierarchyStructure extends LightningElement {

    @api recordId;
    gotResult = false;
    optionSelected = false;
    structure = [];
    selected;
    @wire(FolderHierarchy, { recordId: '$recordId' })
    treestructure({ data, error }) {
        if (data) {
            this.gotResult = true;
            console.log(JSON.stringify(data));
            this.structure = data;
        }
        else if (error) {
            console.error(error);
        }
    }

    handleSelect(event) {
        //set the name of selected tree item
        this.selected = event.detail.name;
        console.log(this.selected);
        this.fileStructure();
        

    }

    fileStructure() {
        // Call the Apex method to retrieve additional data
        getFileStructure({ recordId: this.recordId , selectedId : this.selected})
            .then(result => {
                
                this.optionSelected = true;
                console.log(JSON.stringify(result));
                // Process the returned data
                // ...
            })
            .catch(error => {
                // Handle any errors
                // ...
            });
    }
    
}