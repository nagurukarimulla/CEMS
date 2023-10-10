public with sharing class CatUrl {
    @AuraEnabled
    public static List<String> CatImages() 
    {
        List<String> catImages = new List<String>();
        List<Cat__c> catlist = [select Name,ImageUrl__c from Cat__c];
        for(Cat__c cat:catlist)
        {
            catImages.add(cat.ImageUrl__c);
        }
        return catImages;

    }
}
  