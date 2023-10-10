({
	myAction : function(component, event, helper) {
		var ChildCmp = component.find("ChildComp");
        var retMess = ChildCmp.exposeMethod("Hello","Karim1")
        alert('Return Message is: ' + retMess);
	}
})