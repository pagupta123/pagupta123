({
	packItem : function(component, event, helper) {
        console.log('packItem called');
		var btn = event.getSource();
        btn.set("v.disabled", true);
        var campingItem = component.get("v.item");
        
        if (campingItem != null){
            console.log('campingItem',campingItem);
        	campingItem.Packed__c = true;
        	component.set("v.item", campingItem);
    	}	
	}
})