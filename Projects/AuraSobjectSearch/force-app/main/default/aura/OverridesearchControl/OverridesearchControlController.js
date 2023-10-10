({
    publishOverrideField : function(component, event, helper) {
      let fieldName= component.find("overridefield").get("v.value");
      var appEvent = $A.get("e.c:OverrideAppEvent");
      appEvent.setParams({
        overrideField : fieldName
      });
      appEvent.fire();
    }
})
