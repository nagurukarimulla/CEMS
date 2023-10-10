({
  searchHelper : function(component, event, helper,fields) {
      let object_Name = component.get("v.objectAPIName");
      // get search fields in return 
      // Server action 
      let searchAction = component.get("c.searchRecords");
      // Pass your parameters
      searchAction.setParams({
          searchKey : component.get("v.searchText"),
          fieldApi : component.get("v.searchFieldAPIName"),
          objectName : object_Name,
          displayFields : fields
      });
      searchAction.setCallback(this,function(response){
          let state = response.getState();
          if(state === "SUCCESS"){
              // find the return Data 
              let data = response.getReturnValue();
              
              component.set("v.searchResults",data);
          }
          else{
            alert("ERROR"+JSON.stringify(response.getError()));
          }
      });
      $A.enqueueAction(searchAction);
  },

  getSearchfieldHlp:function(component,event,helper){
    let object_APIName = component.get("v.objectAPIName");
    let fieldsetAPIName = component.get("v.fieldSetName");

    let action=component.get("c.getDisplayFields");
    action.setParams({
      objectName : object_APIName,
      fieldSetName : fieldsetAPIName
    });
    action.setCallback(this,function(response){
      let state = response.getState();
      if(state === "SUCCESS"){
          let results=response.getReturnValue();
          component.set("v.displayFields",results);
          //alert(results);
          helper.searchHelper(component,event,helper,results);
      }
    });
    $A.enqueueAction(action);
  }
})