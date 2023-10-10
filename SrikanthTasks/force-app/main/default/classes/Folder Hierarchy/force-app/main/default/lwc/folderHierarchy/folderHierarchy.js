import { LightningElement, api, wire } from 'lwc';
import getFolderHierarchy from '@salesforce/apex/FolderHierarchyController.getEmployeeFolderStructure';

export default class FolderTreeComponent extends LightningElement {
    @api recordId;
    folderHierarchy;
    selectedFolder ;

    @wire(getFolderHierarchy, { recordId: '$recordId' })
    wiredFolderHierarchy({ data, error}) {
        console.log("data from apex code::" +data);
        if (data) {
            this.folderHierarchy = data;
            console.log(this.folderHierarchy);
        } else if (error) {
            console.error(error);
        }
    }

    handleFolderSelect(event) {
        this.selectedFolder = event.detail; // Assign the entire selected folder object
        console.log(this.selectedFolder);
    }
      

    
}








/*
import { LightningElement, wire } from 'lwc';
import getFolders from '@salesforce/apex/FolderHierarchyController.getFolders';

export default class FolderHierarchy extends LightningElement {
    folderHierarchy;

    @wire(getFolders, { recordId: '$recordId' })
    fetchFolders({ error, data }) {
        if (data) {
            this.folderHierarchy = this.prepareHierarchy(data);
        } else if (error) {
            console.error('Error retrieving folders:', error);
        }
    }

    prepareHierarchy(data) {
        const folderMap = {};
        const rootFolders = [];

        // Iterate over the data map to build the folder hierarchy
        for (const parentFolderId in data) {
            const childFolders = data[parentFolderId];

            const parentFolder = {
                id: parentFolderId,
                name: '',
                items: []
            };

            childFolders.forEach(childFolder => {
                const folderInfo = {
                    id: childFolder.id,
                    name: childFolder.name,
                    items: []
                };
                parentFolder.items.push(folderInfo);
            });

            rootFolders.push(parentFolder);
        }

        return rootFolders;
    }
}
*/
/*
import { LightningElement, wire, api } from 'lwc';
import getFolders from '@salesforce/apex/FolderHierarchyController.getFolders';

export default class FolderHierarchy extends LightningElement {
    @api recordId;
    folderHierarchy;

    @wire(getFolders, { recordId: '$recordId' })
    fetchFolders({ error, data }) {
        if (data) {
            this.folderHierarchy = this.prepareHierarchy(data);
        } else if (error) {
            console.error('Error retrieving folders:', error);
        }
    }

    prepareHierarchy(data) {
        const rootFolders = [];
        const folderMap = {};

        // Build the folder hierarchy map
        for (let folderId in data) {
            const folderInfo = {
                id: folderId,
                name: '',
                items: data[folderId]
            };
            folderMap[folderId] = folderInfo;
        }

        // Find the root folders and populate their names
        for (let folderId in folderMap) {
            const folderInfo = folderMap[folderId];
            if (!folderMap.hasOwnProperty(folderInfo.id)) {
                folderInfo.name = folderInfo.items[0].name;
                rootFolders.push(folderInfo);
            }
        }

        return rootFolders;
    }
}
*/
/*
import { LightningElement, wire } from 'lwc';
import getFolders from '@salesforce/apex/FolderHierarchyController.getFolders';

export default class FolderHierarchy extends LightningElement {
    folderHierarchy;
    selectedFolder;

    @wire(getFolders)
    fetchFolders({ error, data }) {
        if (data) {
            console.log('Data from apex==>'+data );
            this.folderHierarchy = this.prepareHierarchy(data);
        } else if (error) {
            console.error('Error retrieving folders:', error);
        }
    }

    prepareHierarchy(folders) {
        const folderMap = {};
        const rootFolders = [];
    
        // Build a map of folders using their IDs
        folders.forEach((folder) => {
            const folderInfo = {
                label: folder.Name, // Use folder.Name instead of folder.name
                name: folder.Id,
                expanded: false,
                items: [],
            };
            folderMap[folder.Id] = folderInfo;
    
            const parentId = folder.Folder__c; // Use folder.Folder__c instead of folder.parentId
            if (!parentId) {
                // Add root folders directly to the rootFolders array
                rootFolders.push(folderInfo);
            } else if (folderMap[parentId]) {
                // Add child folders to their parent's items array
                folderMap[parentId].items.push(folderInfo);
            }
        });
    
        return rootFolders;
    }
    
}
*/