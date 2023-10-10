public class MixedDML {
    public static void insertNonSetup(){
        Account acc = new Account();
        acc.Name = 'Non setup Account Record Test';
        insert acc;
        System.debug('Account insertion completed');
        insertSetup();
        System.debug('user insertion completed');
        calloutMethod();
        System.debug('Callout is called');
    }
         
    @future()
    public static void insertSetup(){
        Profile prof = [select id from profile where  name = 'Cross Org Data Proxy User'];
        UserRole userRole = [select id from UserRole where Name = 'VP, Marketing' ];
        System.debug('User creation starts');
        User u = new User();
        u.firstname = 'New';
        u.lastname = 'SetupUser';
        u.Alias = 'nsuser';
        u.email = 'user.usersetup@sfdc.com';
        u.ProfileId = prof.id;
        u.UserRoleId = userRole.id;
        u.emailencodingkey = 'UTF-8';
        u.LanguageLocaleKey = 'en_US';
        u.TimeZoneSidKey = 'America/Los_Angeles';
        u.Username = 'apexfuturemethod@test.com';
        insert u;
        System.debug('User Object id ---------->' + u.Id); 
    }
    
    @future(callout=true)
    public static void calloutMethod(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
  // If the request is successful, parse the JSON response.
       if(response.getStatusCode() == 200) {
    // Deserialize the JSON string into collections of primitive data types.
    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    // Cast the values in the 'animals' key as a list
    List<Object> animals = (List<Object>) results.get('animals');
    System.debug('Received the following animals:');
    for(Object animal: animals) {
        System.debug(animal);
    }
}
    }
}