public class AccessModifiers {
    private String name;
    private Integer age;
    
    public void setname(String n){
        name = n;
    }
    public void setage(Integer a){
        if(a<0){
            System.debug('age should be atleat 1');
            a=1;
        }
        else{
            age=a;
        }
    }
    public void display(){
        System.debug('Name :'+ name);
        System.debug('Age :'+ age);
    }
}