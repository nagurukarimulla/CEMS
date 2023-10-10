({
    searchHelper : function(component, event, helper) {
        let objectName = component.get("v.objectAPIName");
        // get search fields in return 
        let queryFields = helper.getSearchFieldsHlp(objectName);
        component.set("v.displayFields",queryFields);
        // Server action 
        let searchAction = component.get("c.searchRecords");
        // Pass your parameters
        searchAction.setParams({
            searchkey : component.get("v.searchText"),
            fieldApi : component.get("v.searchFieldApiName"),
            objectName : objectName,
            requiredFields : queryFields
        });
        searchAction.setCallback(this,function(response){
            let state = response.getState();
            if(state === "SUCCESS"){
                // find the return Data 
                let data = response.getReturnValue();
                
                component.set("v.searchResults",data);
            }
            else{
                alert("ERORR"+JSON.stringify(response.getError()));
            }
        });
        $A.enqueueAction(searchAction);
    },

    getSearchFieldsHlp : function(objectName){
        // How to define array ?
       if(objectName === "Account"){
        return ["Name","Rating","Phone","Description"];
       }
       else if(objectName === "Contact"){
        return ["FirstName" , "LastName" , "Phone" , "Email"];
       }

       else {
        return null;
       }
    }
})