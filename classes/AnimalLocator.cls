public class AnimalLocator {
    
    public static String getAnimalNameById(Integer id)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        String strResp = '';
        system.debug('******response '+response.getStatusCode());
        system.debug('******response '+response.getBody());
        // If the request is successful, parse the JSON response.
        
        if (response.getStatusCode() == 200)  {
            
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            Map<string,object> animals = (map<string,object>) results.get('animal');
            System.debug('Received the following animals:' + animals );
            strResp = string.valueof(animals.get('name'));
            System.debug('strResp >>>>>>' + strResp );
            
        }
        return strResp ;
   }
    
    /*public static String getAnimalNameById(Integer ID){
        HttpResponse response = makeGetCallout(ID);
       
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            
            // Deserializes the JSON string into collections of primitive data types.
            AnimalResult anObj = (AnimalResult)JSON.deserialize(response.getBody(), AnimalResult.class);
            if (anObj != null){
                System.debug('Animal:'+anObj.animal);
                return anObj.animal.name;
            }
        }
        return '';
    }

    public static HttpResponse makeGetCallout(Integer ID) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/:' + ID);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        HttpResponse response = http.send(request);
        System.debug('Response::'+response.getBody());
        
        return response;
    } 
    
    public class AnimalResult{
        public Animal animal {get;set;}
    }
    
    public class Animal{
        public Integer id {get;set;}
        public String name {get;set;}
        public String eats {get;set;}
        public String says {get;set;}
       
    }*/
}