<aura:application extends="force:slds"> 
   <aura:attribute name="campingItem" type="Camping_Item__c" 
                   default="{ 'sobjectType': 'Camping_Item__c',
                                'Name': 'Parent Test',
                                'Price__c': 2000,
                                'Quantity__c':500,
                                'Packed__c': false}"/>
	<div class="slds-card">
    	<c:camping />
    </div>
    <div class="slds-card">
        <c:campingListItem item="{!v.campingItem}"/>
    </div>
    
   
</aura:application>