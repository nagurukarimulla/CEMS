public class constant {
static final Integer PRIVATE_INT_CONST = 200;
   static final Integer PRIVATE_INT_CONST2; 

   public static void calculate() {
       System.debug(PRIVATE_INT_CONST);
   }

   static {
       PRIVATE_INT_CONST2 = 400;
       
   }
}