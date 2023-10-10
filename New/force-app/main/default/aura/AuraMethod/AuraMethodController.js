({
    doAction : function(component, event, helper) {
        let payload = event.getParam('arguments');
        alert(payload.param1 +":"+payload.param2);
    }
})