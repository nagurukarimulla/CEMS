public class TemperatureConvertor {
    public static Decimal FahrenhietToCelsius(Decimal fh){
       Decimal cs =  (fh-32)*5/9;
        System.debug('Temp to celsius -'+cs.setScale(2));
        return cs.setScale(2);
    }
}