({
 myAction : function(component, event, helper) {
      var action = component.get("c.getPaymentDetails");
        
        action.setCallback(this, function(data) {
            component.set("v.policyMap", data.getReturnValue());
        });
        $A.enqueueAction(action);

  }
})