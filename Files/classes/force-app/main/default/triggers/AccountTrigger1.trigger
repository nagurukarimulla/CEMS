trigger AccountTrigger1 on Account (before insert) {
  if(trigger.isBefore && trigger.isInsert){
        for(Account accRec : trigger.new){
            if(accRec.ShippingCity == null){
                accRec.ShippingCity = accRec.BillingCity;
            }
            if(accRec.ShippingState == null){
                accRec.ShippingState = accRec.BillingState;
            }
            if(accRec.ShippingCountry == null){
                accRec.ShippingCountry = accRec.BillingCountry;
            }
            if(accRec.ShippingStreet == null){
                accRec.ShippingStreet = accRec.BillingStreet;
            }
        }
    }
}