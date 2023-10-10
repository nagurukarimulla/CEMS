@isTest
public class CountrypriorityTest {
    @isTest 
    static void getCountrypriorityTest(){
       String priority = CountryPriority.getCountryprority('Russia');
        System.assertEquals('Normal', priority);
    }
    @isTest 
    static void getHighCountrypriorityTest(){
       String priority = CountryPriority.getCountryprority('INDIA');
        System.assertEquals('High', priority);
    }
     @isTest 
    static void getNullCountrypriorityTest(){
       String priority = CountryPriority.getCountryprority('Pakistan');
        System.assertEquals(null, priority);
    }
}