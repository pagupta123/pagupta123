public class CustomDataTableController {

}
//Controller class to update product request and line items
/*public class UpdateProductRequestApex {
    
    // Method to retrieve locations - "East" and "West"
    @auraEnabled
    public static List<FSLLocation> getLocations(){
        List<FSLLocation> fslLocationList = new List<FSLLocation>();
        for(Schema.Location loc : [Select Id, Name from Location 
                                   where (name = 'East' or name = 'West') 
                                   order by name asc]){
            FSLLocation fslLocation = new FSLLocation();
            fslLocation.value = loc.Id;
            fslLocation.label = loc.Name;
            fslLocationList.add(fslLocation);
        }
        return fslLocationList;
    }
    
    // Method returns product requests along with line items
    @auraEnabled
    public static List<FSLProductRequest> getProductRequestsWithLineItems(String selectedLocation){
        List<FSLProductRequest> fslProductRequestList = new List<FSLProductRequest>();
        if (selectedLocation != null || selectedLocation != '') {
            FSLProductRequest fslProductRequest;
            for(ProductRequest prodRequest : [Select Id, 
                                          ProductRequestNumber, 
                                          Status, 
                                          ADI_Pickup_Branch__c,
                                          PO_Number__c,
                                           DestinationLocation.Id,
                                           DestinationLocation.Name,
                                           SourceLocation.Id, 
                                           SourceLocation.Name, 
                                           NeedByDate, 
                                           ShipToAddress, 
                                           ShipmentType,
                                           CreatedDate,
                                           (Select Id, 
                                                QuantityRequested,
                                                Product2.Id,
                                                Product2.Name, 
                                                Product2.ProductCode, 
                                                Product2.Cost__c,
                                                Product2.Vendor__c
        									from ProductRequestLineItems )

									        from ProductRequest
                                            where status = 'DRAFT'
                                            and DestinationLocation.ParentLocationId =: selectedLocation
                                         ]){
                fslProductRequest = new FSLProductRequest();
                fslProductRequest.productReq = prodRequest;
                fslProductRequest.productReqId = prodRequest.Id;
                fslProductRequest.pickupBranch = prodRequest.ADI_Pickup_Branch__c;
                fslProductRequest.poNumber = prodRequest.PO_Number__c;
                fslProductRequest.destinationLocationName = prodRequest.DestinationLocation.Name;
                fslProductRequest.sourceLocationId = prodRequest.SourceLocation.Id;
                fslProductRequest.sourceLocationName = prodRequest.SourceLocation.Name;
                fslProductRequest.needByDate = String.valueOf(prodRequest.NeedByDate);
                System.Address address = prodRequest.ShipToAddress;
             
                if (address != null){
                     String addressStr = '';
                     if (address.getStreet() != null){
                       addressStr += address.getStreet() + ', ';  
                     }
                     if (address.getCity() != null){
                       addressStr += address.getCity() + ', ';  
                     }
                     if (address.getState() != null){
                       addressStr += address.getState() + ' ';  
                     }
                     if (address.getCountry() != null){
                         addressStr += address.getPostalCode() + ', ';  
                     }
                     if (address.getPostalCode() != null){
                         addressStr += address.getCountry() + ' ';
                     }
                       
                     fslProductRequest.shipToAddress = addressStr;
                }
            
                fslProductRequest.shipmentType = prodRequest.ShipmentType;
                fslProductRequest.createdDate = prodRequest.CreatedDate.format();      
                fslProductRequest.status = prodRequest.Status;  
                fslProductRequest.isChecked = false;
                List<FSLProductRequestLineItem> lineItems = new List<FSLProductRequestLineItem>();
                if (prodRequest.ProductRequestLineItems.size() > 0){
                    for(ProductRequestLineItem item : prodRequest.ProductRequestLineItems){
                        FSLProductRequestLineItem lineItem = new FSLProductRequestLineItem();
                        lineItem.productName = item.Product2.Name;
                        lineItem.productCode = item.Product2.ProductCode;
                        lineItem.productCost = item.Product2.Cost__c;
                        lineItem.productVendor = item.Product2.Vendor__c;
                        lineItem.productId = item.Product2.Id;
                        lineItem.lineItemId = item.Id;
                        lineItem.quantityRequested = item.QuantityRequested;
                        lineItem.quantityEditMode = false;
                        lineItem.quantityErrorMode = false;
                        lineItem.productEditMode = false;
                        lineItem.productErrorMode = false;
                        lineItem.lineItem = item;
                        lineItems.add(lineItem);
                    }
                    fslProductRequest.lineItems.addAll(lineItems);
                }
                fslProductRequestList.add(fslProductRequest);
            }
        }
        return fslProductRequestList;
    }
    
    // Method to update product requests Status field
    @AuraEnabled
    public static List<FSLProductRequest> updateProductRequestStatus(List<FSLProductRequest> lstProductRequest, 
                                                                     String selectedLocation,
                                                                    String selectedStatus) {
        List<ProductRequest> updateProductRequestLst = new List<ProductRequest>();
        for (FSLProductRequest prodRequest : lstProductRequest){
            if (prodRequest.isChecked){
            	updateProductRequestLst.add (new ProductRequest (id = prodRequest.productReqId, 
                                        status = selectedStatus));
            }            
        }               
        update updateProductRequestLst;
        return getProductRequestsWithLineItems(selectedLocation);
    }
    
    
    // Method to update product requests and line items
    @AuraEnabled
    public static List<FSLProductRequest> updateProductRequests(List<FSLProductRequest> lstProductRequest, String selectedLocation) {
        List<ProductRequest> updateProductRequestLst = new List<ProductRequest>();
        List<ProductRequestLineItem> updateProductRequestLineItemLst = new List<ProductRequestLineItem>();
        for (FSLProductRequest prodRequest : lstProductRequest){
            updateProductRequestLst.add (new ProductRequest (id = prodRequest.productReqId, 
                                        status = prodRequest.status, 
                                        SourceLocationId = prodRequest.sourceLocationId));
            for (FSLProductRequestLineItem lineItemRec : prodRequest.lineItems){
                if (lineItemRec.lineItem.QuantityRequested != lineItemRec.quantityRequested
                || lineItemRec.lineItem.Product2.Id != lineItemRec.productId){
                    updateProductRequestLineItemLst.add (new ProductRequestLineItem (id = lineItemRec.lineItemId, 
                                                        QuantityRequested = lineItemRec.quantityRequested, 
                                                        product2Id = lineItemRec.productId));
                }
                
            }
            
        }
        
        if (updateProductRequestLineItemLst.size() > 0){
            update updateProductRequestLineItemLst;
        }
        update updateProductRequestLst;
        return getProductRequestsWithLineItems(selectedLocation);
    }
    
    public class FSLLocation{
        @AuraEnabled public String value { get; set; }
        @AuraEnabled public String label { get; set; }
        public FSLLocation(){}

    }
    
    public class FSLProductRequest{
        @AuraEnabled public ProductRequest productReq { get; set; }
        @AuraEnabled public String productReqId { get; set; }
        @AuraEnabled public String pickupBranch { get; set; }
        @AuraEnabled public String poNumber { get; set; }
        @AuraEnabled public String destinationLocationName { get; set; }
        @AuraEnabled public String destinationLocationId { get; set; }
        @AuraEnabled public String sourceLocationName { get; set; }
        @AuraEnabled public String sourceLocationId { get; set; }
        @AuraEnabled public String needByDate { get; set; }
        @AuraEnabled public String shipToAddress { get; set; }
        @AuraEnabled public String shipmentType { get; set; }
        @AuraEnabled public String createdDate { get; set; }  
        @AuraEnabled public String status { get; set; } 
        @AuraEnabled public Boolean isChecked { get; set; } 
        @AuraEnabled public Boolean ProdReqId { get; set; } 
        @AuraEnabled public List<FSLProductRequestLineItem> lineItems { get; set; }
        public FSLProductRequest(){
            lineItems = new List<FSLProductRequestLineItem>();
        }

    }
    
    public class FSLProductRequestLineItem{
        @AuraEnabled public String productId { get; set; }
        @AuraEnabled public String lineItemId { get; set; }
        @AuraEnabled public String productName { get; set; }
        @AuraEnabled public String productCode { get; set; }
        @AuraEnabled public Decimal productCost { get; set; }
        @AuraEnabled public String productVendor { get; set; }
        @AuraEnabled public Decimal quantityRequested { get; set; }
        @AuraEnabled public Boolean quantityEditMode { get; set; }
        @AuraEnabled public Boolean quantityErrorMode { get; set; }
        @AuraEnabled public Boolean productEditMode { get; set; }
        @AuraEnabled public Boolean productErrorMode { get; set; }
        @AuraEnabled public ProductRequestLineItem lineItem { get; set; }
        public FSLProductRequestLineItem(){}

    }
    
    // Method for fetching sObject lookup values dynamic  
    @AuraEnabled
    public static List < sObjectOption > getSObjectSelectOptions(String objectName) {
        
        List < sObjectOption > allOpts = new list < sObjectOption > ();
        // Get the object type of the SObject.
        String qyeryStr = 'Select id, Name from ' + objectName +' order by Name asc';
        List<sObject> sobjList = Database.query(qyeryStr);

        for (sObject obj : sObjList){
            sObjectOption option = new sObjectOption();
            option.objId = (String)obj.get('id');
            option.objName = (String)obj.get('Name');
            allOpts.add(option);
        }
        
        return allOpts;
    }
    
    // sObject select option wrapper
    public class sObjectOption{
        @AuraEnabled public String objId { get; set; }
        @AuraEnabled public String objName { get; set; }
        public sObjectOption(){}
    }
    
    // Method for fetching picklist values dynamic  
    @AuraEnabled
    public static List < String > getselectOptions(sObject objObject, string fld) {
        system.debug('objObject --->' + objObject);
        system.debug('fld --->' + fld);
        List < String > allOpts = new list < String > ();
        // Get the object type of the SObject.
        Schema.sObjectType objType = objObject.getSObjectType();
        
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values =
            fieldMap.get(fld).getDescribe().getPickListValues();
        
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        system.debug('allOpts ---->' + allOpts);
        allOpts.sort();
        return allOpts;
    }
    
    @auraEnabled
    public static String sendPrdReqtoADI_FTP(String prdReqIdSetString){
        system.debug('Set of Ids==='+prdReqIdSetString);
        Boolean isUpdateSucess;
        Set<Id> productRequestIds = new Set<Id>((List<Id>)prdReqIdSetString.split(','));
        if(productRequestIds.size() > 0){
            isUpdateSucess = FTPIntegrationCallout.updateProductRequest(productRequestIds);
        }
        return null;
    }
    
}*/