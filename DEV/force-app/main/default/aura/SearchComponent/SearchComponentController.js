({
    searchAction : function(component, event, helper) {
       helper.getSearchfieldHlp(component, event, helper);
    },
    handleOverrideEvent:function(component,event,helper){
        let newFieldName = event.getParam("overrideField");
        component.set("v.searchFieldAPIName",newFieldName);
        alert("Overrided..!!!"+newFieldName);
    }
})