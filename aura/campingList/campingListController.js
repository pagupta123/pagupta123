({
    // Load items from Salesforce
    doInit: function(component, event, helper) {
        // Create the action
        var action = component.get("c.getItems");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    handleAddItem: function(component, event, helper) {
        var itemToAdd = event.getParam("item");
        
        var action = component.get("c.saveItem");
        action.setParams({
            "item": itemToAdd
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var items = component.get("v.items");
                items.push(response.getReturnValue());
                component.set("v.items", items);
                console.log("Items after: " + JSON.stringify(items));
            }
        });
        $A.enqueueAction(action);
        
    }
   
    
})