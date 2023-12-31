public class AnimalLocator {
    public static String getAnimalNameById(Integer id){
        Http http = new Http(); 
        HttpRequest request = new HttpRequest(); 
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        System.debug('>>>>>>>'+id);
        HttpResponse response = http.send(request);
      Object animals;
        String returnValue;
       
        // If the request is successful, parse the JSON response
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('Result looks like===>'+ result);
            System.debug('Response get body >>>>>'+response.getBody());
            animals = result.get('animal');
            System.debug(animals);
        }
        if (animals != NULL  ) {
            Map<String, Object> result1 = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(animals));
            returnValue =(String) result1.get('name');
        }
        return returnValue;
    }
}