({
	showMessage : function(component, event, helper) {
		var params = event.getParam('arguments');
        if(params)
        {
            var param1 = params.param1;
            var param2 = params.param2;
            alert('Message: ' + param1 + ' ' + param2);
            return 'success';
        }
        
	}
})