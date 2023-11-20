({
    /*createItem: function(component, item) {
        var theItems = component.get("v.items");
 
        // Copy the expense to a new object
        // THIS IS A DISGUSTING, TEMPORARY HACK
        var newItem = JSON.parse(JSON.stringify(item));
 
        theItems.push(newItem);
        component.set("v.items", theItems);
        console.log("Items : " + JSON.stringify(theItems));
    },*/
    
    
    resetNewItem: function(component){
        var newItem = {sobjectType: 'Camping_Item__c',
                                'Name': '',
                                'Price__c': 0,
                                'Quantity__c':0,
                                'Packed__c': false};
        component.set("v.newItem",newItem);
    }
})