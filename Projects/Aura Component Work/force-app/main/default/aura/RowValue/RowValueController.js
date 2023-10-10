({
    doInit : function(component, event, helper) {
        let data = component.get("v.dataRecord");
        let fieldname = component.get("v.fieldName");
        console.log(fieldname+"--"+data[fieldname]);
        component.set("v.fieldValue",data[fieldname]);
    },
    fieldChangeAction : function(component , event , helper){
        let isEdit = component.get("v.isEditMode");
        if(isEdit){
            let field_Value = component.get("v.fieldValue");
            let fieldName = component.get("v.fieldName");
            let row_Index = component.get("v.rowIndex");
            var dataEvent = component.getEvent("dataBindevent");
            dataEvent.setParams({
                fieldAPIName : fieldName,
                fieldValue : field_Value,
                rowIndex : row_Index
            });
            dataEvent.fire();
        }
    }
})