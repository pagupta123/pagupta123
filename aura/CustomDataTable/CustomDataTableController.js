({
    
  
	doInit : function(component, event, helper) {
		helper.doInit(component, event, helper);
	},

    // Method to initialize table data
    init: function (cmp, event, helper) {
        cmp.set("v.isSelectAll", false);
        cmp.set("v.loaded", false);
        helper.fetchPickListVal(cmp, 'Status', 'statusPicklistOpts'); 
        
        helper.fetchSObjectVal(cmp, 'Product2', 'productPicklistOpts');
        helper.fetchSObjectVal(cmp, 'Location', 'locationPicklistOpts');
        cmp.set('v.columns', [
            {label: 'Destination Location', fieldName: 'destinationLocationName', type: 'percent', editable: false },
            {label: 'ADI Pickup Branch', fieldName: 'pickupBranch', type: 'text', editable: false},
            {
                label: 'Created date', fieldName: 'createdDate', type: 'date', editable: false,
                typeAttributes: {
                    year: 'numeric',
                    month: 'short',
                    day: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit'
                }
            },
            
            {
                label: 'Needby date', fieldName: 'needbyDate', type: 'date', editable: false,
                typeAttributes: {
                    year: 'numeric',
                    month: 'short',
                    day: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit'
                }
            },
            {label: 'PO Number', fieldName: 'poNumber', type: 'currency', editable: false },
            {label: 'Product Request Number', fieldName: 'productRequestNumber', type: 'email', editable: false },
            {label: 'ShipTo Address', fieldName: 'shipToAddress', type: 'text', editable: false},
            {label: 'Shipment Type', fieldName: 'shipmentType', type: 'text', editable: false },
        	{label: 'Source Location', fieldName: 'sourceLocationName', type: 'text', editable: true },
            {label: 'Status', fieldName: 'status', type: 'text', editable: true }
        ]);
		helper.fetchData(cmp);
      
    },
    
    // Method to handle save event
    handleSave: function(component, event, helper) {
        // Check required fields(Name) first in helper method which is return true/false
        if (helper.requiredValidation(component, event)){
        	helper.saveData(component, event, helper);
        } 
    },
    
    // Method to handle cancel event
    handleCancel : function(component, event, helper){
       component.set("v.showSaveCancelBtn",false);
       helper.fetchData(component, event, helper);
    },
    
    // Method to show Success/Error
    recordUpdatedChange : function(component, event, helper){
        if (component.get("v.saveSuccess") == true){
       		helper.showSuccess(component, event, helper);
            component.set("v.saveSuccess", false);
        }else if (component.get("v.saveError") == true){
            helper.showError(component, event, helper);
            component.set("v.saveError", false);
        }
    },
    
    // Method to check select all checkbox
    selectAllCheckbox: function(component, event, helper){
        var getData = component.get("v.data");
        var checkvalue = component.find("selectAllPR").get("v.value");
        if (checkvalue == true) {
            component.set("v.showStatusDropdown",true);            
        }
        else {
            component.set("v.showStatusDropdown",false);
        }
        for (var i=0; i<getData.length; i++){
            if(checkvalue == true){
            	getData[i].isChecked = true;
            }else{
                getData[i].isChecked = false;
            }
        }
        component.set("v.data", getData);
        
    },
    
    // Method to handle change status button functionality
    changeStatus: function(component, event, helper) {        
    	helper.updateStatus(component, event, helper);        
    },
    // Method to handle change status button functionality
    SubmitToADI: function(component, event, helper) {        
    	helper.sendSelectedPrdReq(component, event, helper);        
    },
});