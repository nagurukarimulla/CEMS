({
    SubHlp : function(component, event, helper) {
         // Get the empApi component.
         const empApi = component.find("empApi");
         // Get the channel from the input box.
         var channel = component.find("channel").get("v.value");
         const replayId = -1;
 
         // Callback function to be passed in the subscribe call.
         // After an event is received, this callback prints the event
         // payload to the console.
         const callback = function (message) {
             console.log("Event Received : " + JSON.stringify(message));
             //var msg = JSON.stringify(message.data.payload.FieldValue__c);
             var Fieldmsg = JSON.stringify(message.data.payload.Name);
             console.log("Event Received : " + msg);
             
             let d = component.get("v.NewValueUpdate");
             d.push(Fieldmsg +":"+msg);
             component.set("v.NewValueUpdate",d);
         };
 
         // Subscribe to the channel and save the returned subscription object.
         empApi.subscribe(channel, replayId, callback).then(function(newSubscription) {
             component.set("v.subscription", newSubscription);
         });
    }
})