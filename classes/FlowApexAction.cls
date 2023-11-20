public class FlowApexAction {
   
    @InvocableMethod( label='Create Contact' description='Create Contact using Title' category='Callout' )
    public static void getTitle( List < String > inputs ) {
       
        system.debug( 'Inputs is ' + inputs );
        createContact( inputs.get( 0 ) );
       
    }
   
    @future( callout=true )
    public static void createContact( String strInput ) {
       
        List < String > listInputs = strInput.split( ',' );
        HTTP h = new HTTP();
        HTTPRequest req = new HTTPRequest();
        req.setEndPoint( 'https://jsonplaceholder.typicode.com/todos/' + listInputs.get( 0 ) );
        req.setMethod('GET');
        HTTPResponse res = h.send(req); 
        JSONWrapper wrapper = ( JSONWrapper ) JSON.deSerialize( res.getBody(), JSONWrapper.class );
        /*
           If the response contains multiple values, then you can use the below code
           List < JSONWrapper > listWrapper = (List < JSONWrapper >) JSON.deSerialize(res.getBody(), List < JSONWrapper >.class);
        */
        Contact objContact = new Contact();
        objContact.LastName = wrapper.title;
        objContact.AccountId = listInputs.get( 1 );
        system.debug( 'Contact is ' + objContact );
        insert objContact;
       
    }
   
    public class JSONWrapper {
       
        public Integer userId;
        public Integer id;
        public String title;
        public Boolean completed;
       
    }
   
}