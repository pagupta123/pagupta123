public class orderTriggerHandler{

   public static void afterInsert(List<Order> newList){
   List<Id> orderIds = new List<Id>();
      for(Order order : newList){
          orderIds.add(order.id);
      }
      callCreateSalesOrderWS(orderIds);
   }
   
   // Method to be WS Callout for Order creation
  //  @param List of new after insert orders
  //  @return void.
   @future(callout=true)
   public static void callCreateSalesOrderWS(List<ID> ordIds)
   {   
       List<Order> updateOrderResponse = new List<Order>();
       schemasStrykerComSalesorderV1.IntegrationHeaderType integrationHeader = new schemasStrykerComSalesorderV1.IntegrationHeaderType();
       schemasStrykerComSalesorderV1.orderHeaderType orderHeader = new schemasStrykerComSalesorderV1.orderHeaderType();
       
      Order ord = new Order(id=ordIds[0]);
           
        // Mapping IntegrationHeader
      integrationHeader = addIntegrationHeaderType(integrationHeader);

       //Mapping orderHeaderType
       orderHeader = addorderHeaderType(orderHeader,ord);
       
       
        
       // Mapping lineItemsType
       schemasStrykerComSalesorderV1.lineItemsType lineItems = new schemasStrykerComSalesorderV1.lineItemsType();
       
       // Mapping attachmentsType
       schemasStrykerComSalesorderV1.attachmentsType attachments = new schemasStrykerComSalesorderV1.attachmentsType();
        
       // Process Order 
       

       commonsalesorderbpelprocess_icCommo.SalesOrder_ICPort  comSalesOrderProcess = new commonsalesorderbpelprocess_icCommo.SalesOrder_ICPort();
       
       String username = 'integration.dev@stryker.poc';
       String password = 'Stryker@2015';
       Blob headerValue = Blob.valueOf(username + ':' + password);
       String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
       comSalesOrderProcess.inputHttpHeaders_x = new Map<String, String>();
       comSalesOrderProcess.inputHttpHeaders_x.put('Authorization', authorizationHeader);
       
       //sunil debugging
       comSalesOrderProcess.endpoint_x  = 'http://requestb.in/1keibjb1';
       
       
      
       schemasStrykerComSalesorderV1.salesOrderResponseType response  = comSalesOrderProcess.ProcessSalesOrder_IC(integrationHeader, orderHeader, lineItems, attachments);
       //integrationHeader, orderHeader, lineItems, attachments
          
       system.debug('WS CreateOrder Request Integration Header :: ' + integrationHeader);
       system.debug('WS CreateOrder Response Order Header:: ' + orderHeader);
       system.debug('WS CreateOrder Response :: ' + response.toString());
       
     
}

  //  Method to map schemasStrykerComCommonV1.IntegrationHeaderType
  //  @param instance of schemasStrykerComCommonV1.IntegrationHeaderType to be mapped 
  //  @return schemasStrykerComCommonV1.IntegrationHeaderType mapped instance
  
public static schemasStrykerComSalesorderV1.IntegrationHeaderType addIntegrationHeaderType(schemasStrykerComSalesorderV1.IntegrationHeaderType integrationHeader){
        String day = string.valueOf(system.now().day());
        String month = string.valueOf(system.now().month());
        String hour = string.valueOf(system.now().hour());
        String minute = string.valueOf(system.now().minute());
        String second = string.valueOf(system.now().second());
        String year = string.valueOf(system.now().year());
        String strTime = year+'-'+month+'-'+day+' '+hour+':'+minute+':'+second ;
        //2016-07-13 14:25:48
        //2016-7-22 12:1:34
        system.debug('CreatedDateTime::'+strTime);
       integrationHeader.CreationDateTime = strTime ;
       integrationHeader.SenderIdentifier = 'SFDC';
       integrationHeader.ReceiverIdentifier = 'ENDERP';
       return integrationHeader;
}

  //  Method to map schemasStrykerComSalesorderV1.orderHeaderType
  //  @param instance of schemasStrykerComSalesorderV1.orderHeaderType to be mapped , Order for mapping purpose
  //  @return schemasStrykerComSalesorderV1.orderHeaderType mapped instance
  
public static schemasStrykerComSalesorderV1.orderHeaderType addorderHeaderType(schemasStrykerComSalesorderV1.orderHeaderType orderHeader, Order ord){
       
       orderHeader.operation = 'Create';
       orderHeader.businessUnit = 'SFDC';
       orderHeader.orderType = 'SJC Bill Only';
       orderHeader.orderSource = 'SFDC';
       orderHeader.origSysDocumentRef = ord.Id;
       //orderHeader.priceList = 
       //orderHeader.custPoNumber = 
       orderHeader.paymentTerm = 'Net 45, Net 210';
       orderHeader.soldFromOrgId = 88;
       orderHeader.soldToOrgId = 12345;
       orderHeader.shipToOrgId = 456;
       orderHeader.invoiceToOrgId = 123;
       orderHeader.creditCheckHold = 'false';
       orderHeader.salesRep = 'test';
       return orderHeader;
}
   
}