({
    myAction : function(component, event, helper) {
        component.set("v.Columns", [
            {label:"Policy Name", fieldName:"Name", type:"Number"},
            {label:"Term", fieldName:"Term__c", type:"Text"},
            {label:"Status", fieldName:"Status__c", type:"Text"}
        ]);
        
        
        var action = component.get("c.getPolicies");
        action.setParams({
            recordId: component.get("v.recordId")
        });
        action.setCallback(this, function(data) {
            component.set("v.Contacts", data.getReturnValue());
        });
        $A.enqueueAction(action);
        
    }
})