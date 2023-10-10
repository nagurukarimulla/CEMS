@isTest
public class TempConvertorTest {
    @isTest static void testWarmTemp(){
        Decimal celsius = TemperatureConvertor.FahrenhietToCelsius(80);
        System.assertEquals(29.66, celsius);
    }
    
    @isTest static void BoilingPoint(){
        Decimal celsius = TemperatureConvertor.FahrenhietToCelsius(212);
        System.assertEquals(100, celsius);
    }
}