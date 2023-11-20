({
    // Method to fetch table data
    fetchData: function (cmp) {
        if (cmp.get("v.selectedLocation") != ''){
            var action = cmp.get('c.getProductRequestsWithLineItems');
            action.setParams({
                "selectedLocation": cmp.get("v.selectedLocation")               
            });
            action.setCallback(this, $A.getCallback(function (response) {
                var state = response.getState();                
                
                if (state === "SUCCESS") {
                    cmp.set('v.data', response.getReturnValue());
                    cmp.set("v.loaded", true);
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    console.error(errors);
                    cmp.set("v.saveError",true); 
                    cmp.set("v.loaded", true);
                }
                                
            }));
            $A.enqueueAction(action);
        }
    },
    
    // Method to validate fields
    requiredValidation : function(component, event) {
        // get all accounts.. 	
        var allRecords = component.get("v.data");
        var isValid = true;
        // play a for loop on all account list and check that account name is not null,   
        /*for(var i = 0; i < allRecords.length;i++){
            if(allRecords[i].Name == null || allRecords[i].Name.trim() == ''){
                alert('Complete this field : Row No ' + (i+1) + ' Name is null' );
                isValid = false;
            }  
        }*/
        return isValid;
    },
    
    // Method to show toast success message
    showSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: 'The records has been updated successfully.',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
    },
    
    // Method to show toast error message
    showError : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Error',
            message:'Please contact your administrator.',
            duration:' 5000',
            key: 'info_alt',
            type: 'error',
            mode: 'pester'
        });
        toastEvent.fire();
    },
    
    updateStatus: function (component, event, helper) {
       // call the saveAccount apex method for update inline edit fields update 
       var action = component.get("c.updateProductRequestStatus");
       action.setParams({
            'lstProductRequest': component.get("v.data"),
            'selectedLocation': component.get("v.selectedLocation"),
            'selectedStatus' : component.get("v.statusValue")
       });
       action.setCallback(this, function(response) {
           var state = response.getState();
           if (state === "SUCCESS") {
               var storeResponse = response.getReturnValue();
               // set AccountList list with return value from server.
               component.set("v.data", storeResponse);
               // Hide the save and cancel buttons by setting the 'showSaveCancelBtn' false 
               component.set("v.showStatusDropdown",false);
               component.set("v.saveSuccess",true);               
           } else{
               component.set("v.saveError",true);
           }
           component.set("v.isSelectAll", false); 
           
        });
        $A.enqueueAction(action);
    },
    
    //Send the selected Product Request Data to ADI FTP
    sendSelectedPrdReq: function (component, event, helper) {
       // call the saveAccount apex method for update inline edit fields update 
       var action = component.get("c.sendPrdReqtoADI_FTP");
       var getData = component.get("v.data");
       var selectedPrdReqIDs = '';
       for (var i=0; i<getData.length; i++){
       		if(getData[i].isChecked)            
            	selectedPrdReqIDs = selectedPrdReqIDs + getData[i].productReqId +',';
                     
       }    
       action.setParams({
            'prdReqIdSetString': selectedPrdReqIDs
       });
       action.setCallback(this, function(response) {
           var state = response.getState();
           if (state === "SUCCESS") {
               var storeResponse = response.getReturnValue();
               //show success message.
               component.set("v.saveSuccess",true);
               helper.fetchData(component);
           } else{
               component.set("v.saveError",true);
           }
        });
        $A.enqueueAction(action);
    },
    
    // Method to save data
    saveData: function (component, event, helper) {
       // call the saveAccount apex method for update inline edit fields update 
       var action = component.get("c.updateProductRequests");
       action.setParams({
            'lstProductRequest': component.get("v.data"),
            'selectedLocation': component.get("v.selectedLocation")
       });
       action.setCallback(this, function(response) {
           var state = response.getState();
           if (state === "SUCCESS") {
               var storeResponse = response.getReturnValue();
               // set AccountList list with return value from server.
               component.set("v.data", storeResponse);
               // Hide the save and cancel buttons by setting the 'showSaveCancelBtn' false 
               component.set("v.showSaveCancelBtn",false);
               component.set("v.saveSuccess",true);               
           } else{
               component.set("v.saveError",true);
           }
        });
        $A.enqueueAction(action);
    },
    
    // fetch picklist values dynamic from apex controller 
    fetchPickListVal: function(component, fieldName, picklistOptsAttributeName) {
        var action = component.get("c.getselectOptions");
       
        action.setParams({
            "objObject": component.get("v.objInfoForPicklistValues"),
            "fld": fieldName
        });
     
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.set("v." + picklistOptsAttributeName, opts);
               
            }
        });
        $A.enqueueAction(action);
    },
    
    // fetch picklist values dynamic from apex controller 
    fetchSObjectVal: function(component, objName, picklistOptsAttributeName) {
        var action = component.get("c.getSObjectSelectOptions");
        action.setParams({"objectName": objName});
        
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                //console.log(allValues);
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i].objName,
                        value: allValues[i].objId
                    });
                }
                component.set("v." + picklistOptsAttributeName, opts);
            }
        });
        $A.enqueueAction(action);
    },
 
	doInit : function(component, event, helper) {
        var jsonData = JSON.parse(helper.getSampleJSON());
        console.log(jsonData); 
        component.set("v.gridData",jsonData);
	},
    getSampleJSON : function(){
        return '{"rows":[{"vals":[{"val":"Salesforce","cssClass":""},{"val":"SFO","cssClass":""},{"val":"info@Salesforce.com","cssClass":""},{"val":"8602229632","cssClass":"responsiveHide"}]},{"vals":[{"val":"Microsoft","cssClass":""},{"val":"SFO","cssClass":""},{"val":"info@microsoft.com","cssClass":""},{"val":"8602283222","cssClass":"responsiveHide"}]},{"vals":[{"val":"SAP","cssClass":""},{"val":"SFO","cssClass":""},{"val":"info@SAP.com","cssClass":""},{"val":"8600942222","cssClass":"responsiveHide"}]},{"vals":[{"val":"Google","cssClass":""},{"val":"SFO","cssClass":""},{"val":"info@Google.com","cssClass":""},{"val":"8602479222","cssClass":"responsiveHide"}]}],"headers":[{"title":"Client Name","isSortable":true,"dataType":"","cssClass":""},{"title":"Address","isSortable":false,"dataType":"","cssClass":""},{"title":"Email","isSortable":false,"dataType":"","cssClass":""},{"title":"Mobile","isSortable":false,"dataType":"","cssClass":"responsiveHide"}]}';
    }

    
});