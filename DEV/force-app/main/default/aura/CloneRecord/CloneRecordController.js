({
    fetchOppo : function(component, event, helper) {
    helper.fetchOppoHelper(component, event, helper);
    },

    viewRecord  : function(component, event, helper) {
        helper.viewRecordHelper(component, event, helper);

    },
   
    /*
    gotoList : function (component, event, helper) {
    var action = component.get("c.getListViews");
    action.setCallback(this, function(response){
        var state = response.getState();
        if (state === "SUCCESS") {
            var listviews = response.getReturnValue();
            var navEvent = $A.get("e.force:navigateToList");
            navEvent.setParams({
                "listViewId": listviews.Id,
                "listViewName": null,
                "scope": "Opportunity"
            });
            navEvent.fire();
        }
    });
    $A.enqueueAction(action);
}*/
})