global class ProcessInboundMail implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope env) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

        List<Case> cases = [Select Id, Status from Case where Status = 'Closed' AND CreatedDate<LAST_N_DAYS:4 AND ContactEmail = :email.fromAddress];
        
        for(Case singleCase:cases){
            
            if(email.subject.contains(singleCase.Id))
            {
                
                singleCase.Status = 'Re-Open';
                
               // singleCase.Description = email.plainTextBody;
                
            }
        }
        
        update cases;

        result.success = true;
        
        return result;
        
    }
    
}