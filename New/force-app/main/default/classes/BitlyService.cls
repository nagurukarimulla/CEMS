public class BitlyService {
//pass URL as paramaetr and same will be passed to Bitly for shorten

    public string shorten(String courseURL){

        //HTTP post call 1- HTTP Object, 2- HTTp Requesr, 3 HTTP response

        Http h = new HTTP();

        HttpRequest req = new HttpRequest();

        req.setMethod('POST');

        //named cred - callout:credname/url

        req.setEndpoint('callout:Bitly/v4/shorten');

       req.setHeader('Authorization', 'Bearer {!$Credential.Password}');

        req.setHeader('Accept','application/json');

        req.setHeader('Content-Type', 'application/json');

        req.setBody(JSON.serialize(new Map<string,Object>{

            'group_guid'=>'{!$Credential.Username}',

            'long_url'=> courseURL,

            'domain'=>'bit.ly' 

        }));

        HttpResponse res = h.send(req);

        Map<string,Object> response = (Map<string,Object>)JSON.deserializeUntyped(res.getBody());

        string surl = (string ) response.get('link');

        return surl ;

    }
}




//updateAccountrecordsBatchJob acctsBatch = new updateAccountrecordsBatchJob();
//Database.executeBatch(acctsBatch);


//Sample code - Invoke UserName password OAuth2.0 call to get access token


/********************/

    //rest OAUTH Token - POST - REQUEST

   

    //string consumerKey = '3MVG9wt4IL4O5wvLOFgdzmmmlg89wR84tZX.d3s1SO.uWgJMeSDoGtxF_AQn6GV9LGV.GtXQ.1grM7l8pU5IE';

    //string consumersecret = '7D28D41469961BC347BCD34DEAC283BA78EC8FBA42064A22755D7AEA0EAF6B0D';

   

    // HTTP call - Send(HttpRequest) --return -- HTTPResponse ---

   
/*
Http h = new Http();

HttpRequest hreq = new HttpRequest();

hreq.setEndpoint('https://login.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG9wt4IL4O5wvLOFgdzmmmlg89wR84tZX.d3s1SO.uWgJMeSDoGtxF_AQn6GV9LGV.GtXQ.1grM7l8pU5IE&client_secret=7D28D41469961BC347BCD34DEAC283BA78EC8FBA42064A22755D7AEA0EAF6B0D&username=naguruk@cittacore.com&password=Nkarim786v3Ru4bioXfhtaKNrBKhFaVNH9');

hreq.setMethod('POST');

string username = 'naguruk@cittacore.com';

string password = 'Nkarim786v3Ru4bioXfhtaKNrBKhFaVNH9';

blob headervalue = Blob.valueOf(username+':'+password);

string authorizationValue = 'BASIC'+EncodingUtil.base64Encode(headervalue);

hreq.setHeader('Authorization',authorizationValue);

HttpResponse hresp =  h.send(hreq);

system.debug('hresp'+hresp.getBody());

string atoken;

string instanceURL;



JSONParser parser = JSON.createParser(hresp.getBody());

while(parser.nextToken() !=NULL){

    if((parser.getCurrentToken() == JSONTOKEN.FIELD_NAME) && parser.getText()=='access_token'){

    parser.nextToken();

        atoken = parser.getText();

    }

    if((parser.getCurrentToken() == JSONTOKEN.FIELD_NAME) && parser.getText()=='instance_url'){

    parser.nextToken();

        instanceURL = parser.getText();

    }

}

system.debug('instanceURL'+instanceURL);

system.debug('atoken'+atoken);
*/
//CalculateLeadsTotalRevenue cltr = new CalculateLeadsTotalRevenue();
//Database.executeBatch(cltr,6);

//CommonHelper ch = new CommonHelper();
//CommonHelper.doDmlOperations();

/*
Id schoolJobId = System.enqueueJob(new SchoolQueueable());


AsyncApexJob jobDetails = [Select Id, status, totaljobitems, jobitemsprocessed,
                           numberoferrors, Createdby.email from AsyncApexJob
                          where id=:schoolJobId];

System.debug('Job Id is:---'+ jobDetails.Id);

System.debug('Job Status is:---'+ jobDetails.status);
*/

/*
PushTopic pushTopic = new PushTopic();
pushTopic.Name = 'StudentsRecUpdates';
pushTopic.Query = 'select id, Student_Name__c, Address__c,Phone_Number__c,Email__c from Student__c';
pushtopic.ApiVersion = 49.0;
pushTopic.NotifyForOperationCreate = true;
pushTopic.NotifyForOperationUpdate = true;
pushTopic.NotifyForOperationDelete = true;
pushTopic.NotifyForOperationUndelete = true;
pushTopic.NotifyForFields = 'Referenced';
insert pushTopic;
*/
//LeadRestService.getleadInformation();