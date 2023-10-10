({
    editRow : function(component, event, helper) {
       
      component.set("v.isEditModeIndex",component.get("v.rowIndex"));
       console.log("-->"+component.get("v.rowIndex"));
        helper.editRowHlp(component, event, helper);
    },
    handleDataChange : function(component , event , helper){
        helper.dataChangeHandlerHlp(component , event , helper);
    },
    saveRecordAction : function(component , event , helper){
        component.set("v.isActionProcess",true);
        helper.saveHlp(component , event , helper);
    },
    rowEditChange : function(component , event , helper){
        console.log(""+event.getParam('oldValue'));
        console.log(""+event.getParam('value'));
        let currentIndex = component.get("v.isEditModeIndex");
        let isEditMode = component.get("v.isEditMode");
        let rowIndex = component.get("v.rowIndex");
        if(event.getParam('oldValue') != undefined && currentIndex != rowIndex && isEditMode){
        component.set("v.isActionProcess",true);
        helper.saveHlp(component , event , helper);
        }
    }
})