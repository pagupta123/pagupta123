({
    
    // Method to initialize picklist values
    doInit: function(component, event, helper) {
        var lineItems = component.get("v.singleRec.lineItems");
        if (lineItems.length > 0){
            component.set("v.showExpandedMode", true);
        }            
    },
    
    // Method to update showChildren attribute
    showLineItems: function(component, event, helper) {
        var showChildren = component.get("v.showChildren");
        if (showChildren == true){
        	component.set("v.showChildren", false); 
        }else{
           component.set("v.showChildren", true);  
        }
    },
    
    // Method to set options to status picklist
    inlineEditStatus : function(component,event,helper){   
        // show the status edit field popup 
        component.set("v.statusEditMode", true); 
        // after set statusEditMode true, set picklist options to picklist field 
        component.find("status").set("v.options" , component.get("v.statusPicklistOpts"));
        // after the 100 millisecond set focus to input field   
        setTimeout(function(){ 
            component.find("status").focus();
        }, 100);
    },
    
    /*onStatusChange : function(component,event,helper){ 
        // if picklist value change,
        // then show save and cancel button by set attribute to true
        component.set("v.showSaveCancelBtn",true);
    },*/
    
    closeStatusBox : function (component, event, helper) {
       // on focus out, close the input section by setting the 'statusEditMode' att. as false
        component.set("v.statusEditMode", false); 
    },
    
    inlineEditLocation : function(component,event,helper){   
        // show the status edit field popup 
        component.set("v.locationEditMode", true); 
        // after set statusEditMode true, set picklist options to picklist field 
        component.find("location").set("v.options" , component.get("v.locationPicklistOpts"));
        // after the 100 millisecond set focus to input field   
        setTimeout(function(){ 
            component.find("location").focus();
        }, 100);
    },
     
    onLocationChange : function(component,event,helper){ 
        // if picklist value change,
        // then show save and cancel button by set attribute to true
        var selectedVal = component.find("location").get("v.value");
        var locationArray = component.get("v.locationPicklistOpts");
        for (var index = 0; index < locationArray.length; index++) {
            if (locationArray[index].value === selectedVal) {
                component.set("v.singleRec.sourceLocationName", locationArray[index].label);
                break;
            }
    	}        
        component.set("v.showSaveCancelBtn",true);
    },
    
    closeLocationBox : function (component, event, helper) {
       // on focus out, close the input section by setting the 'statusEditMode' att. as false
       
        component.set("v.locationEditMode", false); 
    },
    inlineEditQuantity : function(component,event,helper){               
        var target = event.target; 
		var childIndex = target.getAttribute("data-selected-Index");     
        //console.log(childIndex);
        var lineItems = component.get("v.singleRec.lineItems");
        lineItems[childIndex].quantityEditMode = true;
		component.set("v.singleRec.lineItems", lineItems);         
        component.set("v.showSaveCancelBtn",true);
        // after the 100 millisecond set focus to input field   
        setTimeout(function(){ 
            component.find("inputId").focus();
        }, 100);
    },
    onQuantityChange : function(component,event,helper){
        // if edit field value changed and field not equal to blank,
        // then show save and cancel button by set attribute to true
        if(event.getSource().get("v.value").trim() != ''){ 
            component.set("v.showSaveCancelBtn",true);
        }
    },
    closeQuantityBox : function (component, event, helper) {
        
       
        /*if(event.getSource().get("v.value").trim() == ''){
            component.set("v.showErrorClass",true);
        }else{
            component.set("v.showErrorClass",false);
        }  */      
        var lineItems = component.get("v.singleRec.lineItems");
        for (var index=0; index < lineItems.length; index++){
        	lineItems[index].quantityEditMode = false;
        }       
		component.set("v.singleRec.lineItems", lineItems);
    },
    
    inlineEditProduct : function(component,event,helper){               
        var target = event.target; 
		var childIndex = target.getAttribute("data-selected-Index");     
        
        var lineItems = component.get("v.singleRec.lineItems");
        lineItems[childIndex].productEditMode = true;
		component.set("v.singleRec.lineItems", lineItems);   
        component.find("product").set("v.options" , component.get("v.productPicklistOpts"));
        //component.set("v.showSaveCancelBtn",true);
        // after the 100 millisecond set focus to input field   
        setTimeout(function(){ 
            component.find("product").focus();
        }, 100);
    },
    onProductChange : function(component,event,helper){
        // if edit field value changed and field not equal to blank,
        // then show save and cancel button by set attribute to true
        
        // if picklist value change,
        // then show save and cancel button by set attribute to true
        var selectedVal = component.find("product").get("v.value");
        if(selectedVal != ''){ 
            component.set("v.showSaveCancelBtn",true);
        }
        var productArray = component.get("v.productPicklistOpts");
        var lineItems = component.get("v.singleRec.lineItems");
        var selectedLabel = '';
        for (var index = 0; index < productArray.length; index++) {
            if (productArray[index].value === selectedVal) {
                selectedLabel =  productArray[index].label;
                break;
            }            
    	}
        for (var index = 0; index < lineItems.length; index++) {
            if (lineItems[index].productId == selectedVal){
                lineItems[index].productName = selectedLabel;
                break;
            }
        }
        component.set("v.singleRec.lineItems", lineItems);
    },
    closeProductBox : function (component, event, helper) {
             
       
        var lineItems = component.get("v.singleRec.lineItems");
        for (var index=0; index < lineItems.length; index++){
        	lineItems[index].productEditMode = false;
        }       
		component.set("v.singleRec.lineItems", lineItems);
        
    },
    checkboxSelect : function (component, event, helper) {
        var selectedVal = component.find("selectPR").get("v.value");
        
        if (selectedVal == false && component.get("v.isSelectAll") == true){
            component.set("v.isSelectAll", false);
        }
      	var allRecords = component.get("v.allRecords");
        var showButton = false;
        for (var index=0; index < allRecords.length; index++){
            if (allRecords[index].isChecked == true){
                showButton = true;
            }
        } 
    	component.set("v.showStatusDropdown", showButton);
    }
      
})