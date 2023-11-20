({
	createItem: function(component, newItem) {
        var addItem = component.getEvent("addItem");
        addItem.setParams({ "item": newItem });
        addItem.fire();
        
        newItem = {sobjectType: 'Camping_Item__c',
                   'Name': '',
                   'Price__c': 0,
                   'Quantity__c':0,
                   'Packed__c': false};
        component.set("v.newItem",newItem);
    }
})