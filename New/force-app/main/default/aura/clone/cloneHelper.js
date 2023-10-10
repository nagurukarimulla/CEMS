({
    getopplistFunction : function(component) {
         var action = component.get("c.getopplist"); // replace v by "c" - c is the value //provider which enables you to wire up event handlers and actions for the component
        
        var self = this;
        action.setCallback(this, function(actionResult) {
            
            component.set('v.opportunities', actionResult.getReturnValue());
         });
          $A.enqueueAction(action);
    }
})