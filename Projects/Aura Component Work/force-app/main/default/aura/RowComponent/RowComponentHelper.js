({
    editRowHlp : function(component , event , helper) {
       component.set("v.isEditMode",true);
       let saveCmp = component.find("Save");
       if(saveCmp === undefined){
       $A.createComponent("lightning:button",{
         label : "Save",
         variant : "success",
         onclick : component.getReference("c.saveRecordAction"),
         "aura:id" : "Save",
       },function(newComponent , status , errorMessage){
            if(status === "SUCCESS"){
                let body = component.get("v.body");
                body.push(newComponent);
                component.set("v.body",body);
            }
       });
       // Destroy the component 
       let editComponet = component.find("edit");
       editComponet.destroy();
    }

    },
    dataChangeHandlerHlp : function(component , event , helper){
        let fieldValue = event.getParam("fieldValue");
        let fieldName = event.getParam("fieldAPIName");
        let rowIndex = event.getParam("rowIndex");
        let data = component.get("v.dataSet");
        data[fieldName] = fieldValue;
        component.set("v.dataSet",data);
        let data_d = component.get("v.dataSet");
        console.log(" data_d : "+data_d[fieldName]);
    },
    saveHlp : function(component , event , helper){
        let sobject_Data = component.get("v.dataSet");
        let sObject_Name = component.get("v.objectAPIName");
        helper.callserver(component , event , helper, "saveRecord" , {
            sObjectString : JSON.stringify(sobject_Data),
            sObjectName : sObject_Name
        } )
        .then(
            // resolve handler 
            $A.getCallback(function(result){
                component.set("v.isEditMode",false);
                var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : "Success!",
                        message : "The record has been updated successfully.",
                        duration : "5000",
                        key : "info_alt",
                        type : "success",
                        mode : "pester"
                    });
                    toastEvent.fire();
                    let saveCmp = component.find("Save");
                    saveCmp.destroy();
                    $A.createComponent("lightning:button",{
                        label : "Edit",
                        variant : "brand",
                        onclick : component.getReference("c.editRow"),
                        "aura:id" : "edit"
                      },function(newComponent , status , errorMessage){
                           if(status === "SUCCESS"){
                               let body = component.get("v.body");
                               body.push(newComponent);
                               component.set("v.body",body);
                           }
                      });
            }),
            // Reject Handler
            $A.getCallback(function(error){
                alert('Something went wrong : '+JSON.stringify(error));
            })
        )
        .catch(function(error){
            alert('Something went wrong : '+JSON.stringify(error));
        });
    },
    callserver : function(component , event , helper , apexAction , params){
        let p = new Promise(
            $A.getCallback(
                function(resolve , reject){
                    let action =component.get("c."+apexAction+"");
                    action.setParams(params);
                    action.setCallback(this,function(callBackResult){
                        let callBackState = callBackResult.getState();
        component.set("v.isActionProcess",false);

                        if(callBackState === "SUCCESS"){
                            resolve(callBackResult.getReturnValue());
                        }
                        if(callBackState === "ERROR"){
                            reject(callBackResult.getError());
                        }
                    });
                    $A.enqueueAction(action);
                }
            )
        );
        return p;
    }
})