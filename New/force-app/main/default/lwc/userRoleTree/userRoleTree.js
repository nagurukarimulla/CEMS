import { LightningElement, wire } from 'lwc';
import getUserRoles from '@salesforce/apex/UserRoleController.getUserRoles';

export default class TreeDeeplyNested extends LightningElement {
    @wire(getUserRoles)
    items;

    renderedCallback() {
        if (this.items && this.items.data) {
            let data = JSON.parse(JSON.stringify(this.items.data));
            let itemMap = {};
            data.forEach(item => {
                itemMap[item.userRole.Id] = {
                    label: item.userRole.Name,
                    name: item.userRole.DeveloperName,
                    expanded: true,
                    items: [],
                };
            });

            data.forEach(item => {
                let parentId = item.userRole.ParentRoleId;
                if (parentId) {
                    itemMap[parentId].items.push(itemMap[item.userRole.Id]);
                }
            });

            let roots = [];
            data.forEach(item => {
                if (!item.userRole.ParentRoleId) {
                    roots.push(itemMap[item.userRole.Id]);
                }
            });

            this.items = roots;
        }
    }
}
