({
    SubHlp : function(component, event, helper) {
        
        // Get the empApi component.
        var empApi = component.find("empApi");

        // Get the channel from the input box.
       // var channel = '/data/OpportunityChangeEvent';
      var channel = component.find("channel").get("v.value");

      //  var sObjectName = component.get('v.sObjectName');
      /*  if (sObjectName.endsWith('__c')) {
            // Custom object
            channel = channel + sObjectName.substring('0', sObjectName.length-3) + '__ChangeEvent';
        }
        else {
            // Standard object
            channel = channel + sObjectName + 'ChangeEvent';
        }*/
       // channel = channel + sObjectName + 'ChangeEvent';

        var replayId = '-1';
        
        // Callback function to be passed in the subscribe call.
        // After an event is received, this callback prints the event
        // payload to the console.
        var callback = function (message) {
        //   let msg = console.log("Received [" + message.channel +
        //        " : " + message.data.event.replayId + "] payload=" +
        //        JSON.stringify(message.data.payload));
          // alert("Received [" + message.channel + " : " + message.data.event.replayId + "] ");

         //  alert("payload=" + JSON.stringify(message.data.payload));

           let display = JSON.stringify(message.data.payload.Name);
                
            
            let d = component.get("v.NewValueUpdate");
            d.push('Updated Name: '+ display);
           // alert("d" + d);
            component.set("v.NewValueUpdate",d);
        }
           
        empApi.subscribe(channel, replayId, callback).then(function(newSubscription) {
        //   alert("Subscribed to channel " + newSubscription);
        });
         // Client-side function that invokes the unsubscribe method on the
    // empApi component.
    
    
    }
})