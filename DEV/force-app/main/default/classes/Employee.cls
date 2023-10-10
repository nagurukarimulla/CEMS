public class Employee {
    public String ename;
    public String designation;
    public Decimal salary;
    public void show(){
        System.debug('Employee name :'+ ename);
        System.debug('Employee designation :'+ designation);
        System.debug('Employee salary :'+ salary);
    }

}