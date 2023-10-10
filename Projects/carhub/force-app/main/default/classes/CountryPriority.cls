public class CountryPriority {
    public static String getCountryprority(String Country){
        if(String.isBlank(Country) || Country.length()>6 ){
            return null;
        }
        String priority;
        if(Country == 'INDIA'){
            priority = 'High';
        }
        else{
           priority = 'Normal';
        }
        return priority;
    }
}