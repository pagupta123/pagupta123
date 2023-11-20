// Created for CampingList lightning compoment
public with sharing class CampingListController{

  @AuraEnabled
  public static List<Camping_Item__c> getItems(){
      return [Select id, Name, Price__c, Quantity__c, Packed__c from Camping_Item__c];
  }
  
  @AuraEnabled
  public static Camping_Item__c saveItem(Camping_Item__c item){
      try {
          insert item;
      }catch(Exception ex){
      
      }
      return item;
  }


}