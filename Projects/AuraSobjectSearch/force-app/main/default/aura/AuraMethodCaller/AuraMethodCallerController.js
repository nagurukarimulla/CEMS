({
    knowMore : function(component, event, helper) {
        let cmp = component.find("auramethod");
        component.set("v.knowMoreD",JSON.stringify(cmp));
        cmp.sampleMethod("value1","Value2");
    }
})