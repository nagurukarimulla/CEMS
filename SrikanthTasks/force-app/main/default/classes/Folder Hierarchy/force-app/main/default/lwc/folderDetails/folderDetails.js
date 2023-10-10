import { LightningElement, api } from 'lwc';

export default class FolderDetails extends LightningElement {
  
    @api selectedFolder;

    get folderName() {
        return this.selectedFolder ? this.selectedFolder.name : '';
    }

    get folderId() {
        return this.selectedFolder ? this.selectedFolder.id : '';
    }
}
