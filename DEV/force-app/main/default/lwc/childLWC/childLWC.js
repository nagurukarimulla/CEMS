import { api, LightningElement } from 'lwc';

export default class ChildLWC extends LightningElement {
    searchText;
    handleSearchValue(event){
        this.searchText=event.target.value;
        const myeventName="inputupdated";
        let data={searchValue:event.target.value};
        let dispatchdetails=new CustomEvent(myeventName,{detail:data});
        this.dispatchEvent(dispatchdetails);

    }
   
    @api
    childMethodCall(parentData){
        const data=JSON.parse(parentData);
        console.log("Data : "+ JSON.stringify(data));
        alert("From parent : "+ data.name);
    }
}