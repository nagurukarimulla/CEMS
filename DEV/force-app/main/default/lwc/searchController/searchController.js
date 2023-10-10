import { api, LightningElement } from 'lwc';
import searchResults from '@salesforce/apex/SearchController.searchRecords';
import saveData from '@salesforce/apex/SearchController.saveRecord';

export default class SearchController extends LightningElement {
    @api
    sObjectName;
    searchText;
    searchResults;
    isLoaded=false;

    handleSearchValue(event){
        const _searchvalue=event.target.value;
        this.template.querySelector("lightning-input[data-my-id=outputValue]").value=_searchvalue;
    //Imperative calling to server
      let _params={
         searchkey:_searchvalue,
         fieldApi:"Name",
         objectName:this.sObjectName,
         requiredFields:["Name","Rating"]
      };
    //invoke call to server from the import action name : serachResults
    //actionName(params).then(result=>{}).catch(error=>{})
    
    searchResults(_params)
    .then(result=>{
       // let returnData=result;
       // alert("No.Of Records found: "+ returnData.length);
      this.searchResults=result;
        this.isLoaded=result!==undefined?true:false;
    })
    .catch(error=>{
      alert("Error :"+ JSON.stringify(error));
    })
}
}