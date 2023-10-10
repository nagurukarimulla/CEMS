public virtual class TriggerHandler {
  /*
    1. number of times you need to execute your trigger --> Done
    2. Bypass Logic --> Done
    3. Clear Bypass Logic --> Done 
    4. Event Process ( trigger events ) 
    5. Is this from trigger ( ) --> Done
    6. Exception handling --> Not doing here 
    */
    // Internaluse variables 
    private Boolean isTriggerExecuting;
    private TriggerContext context;
    // static map of handler, time run() was invoked
    private static Map<String,LoopCount> loopCountMap; // Map<ClassName,{Maximum Allow loops , Current execution}
    private static Set<String> bypassHandlers;
    // Intilaize memeory 
    static{
        loopCountMap = new Map<String,LoopCount>();
        bypassHandlers = new Set<String>();
    }

    public TriggerHandler(){
        this.setTriggerContext();
    }

    private void setTriggerContext(){
        this.setTriggerContext(null, false);
    }

    // Set Trigger context
    private void setTriggerContext(String eventName , Boolean testMode){
        if(!Trigger.isExecuting && !testMode){
            this.isTriggerExecuting = false;
            return;
        }
        else{
            this.isTriggerExecuting = true;
        }
        // find out the events 
        if(Trigger.isExecuting){
            if( (Trigger.isBefore && Trigger.isInsert) || (eventName != null && eventName == 'before insert') ){
                this.context = TriggerContext.BEFORE_INSERT;
            }
            if( (Trigger.isAfter && Trigger.isInsert) || (eventName != null && eventName == 'after insert') ){
                this.context = TriggerContext.AFTER_INSERT;
            }
            if( (Trigger.isBefore && Trigger.isUpdate) || (eventName != null && eventName == 'before update') ){
                this.context = TriggerContext.BEFORE_UPDATE;
            }
            if( (Trigger.isAfter && Trigger.isUpdate) || (eventName != null && eventName == 'after update') ){
                this.context = TriggerContext.AFTER_UPDATE;
            }
            if( (Trigger.isAfter && Trigger.isDelete) || (eventName != null && eventName == 'after delete') ){
                this.context = TriggerContext.AFTER_DELETE;
            }
            if( (Trigger.isBefore && Trigger.isDelete) || (eventName != null && eventName == 'before delete') ){
                this.context = TriggerContext.BEFORE_DELETE;
            }
            if( (Trigger.isAfter && Trigger.isUndelete) || (eventName != null && eventName == 'after undelete') ){
                this.context = TriggerContext.AFTER_UNDELETE;
            }
        }
    }
    // event process ( core feture is this framework)
    public void run(){
        // Is this from trigger 
       if(!validateRun()){  
            return;
       }
       // We need to loopincrement
       addToLoopCount();
       // Now its a time dispatch events 
       switch on this.context{
            when BEFORE_INSERT{
                this.beforeInsert();
            }
            when AFTER_INSERT{
                this.afterInsert();
            }
            when AFTER_UPDATE{
                this.afterupdate();
            }
            when BEFORE_UPDATE{
                this.beforeUpdate();
            }
            when BEFORE_DELETE{
                this.beforeDelete();
            }
            when AFTER_DELETE{
                this.afterdelete();
            }
            when AFTER_UNDELETE{
                this.afterUndelete();
            }
       }

    }

    // Context specific dispatchers 
    public virtual void beforeInsert(){}
    public virtual void afterInsert(){}
    public virtual void beforeUpdate(){}
    public virtual void afterupdate(){}
    public virtual void beforeDelete(){}
    public virtual void afterdelete(){}
    public virtual void afterUndelete(){}



    public void setMaxLoopCount(Integer max){
        String handlerName = this.getHandlerName();
        if(!loopCountMap.containsKey(handlerName)){
            loopCountMap.put(handlerName, new LoopCount());
        }
        else{
            loopCountMap.get(handlerName).setMax(max);
        }
    }
    // AddlOppcount Logic
    private void addToLoopCount(){
        String handlerName = this.getHandlerName();
        if(loopCountMap.containsKey(handlerName)){ // This valids when there is value of that particular handler 
            // I Need add up the countr --> increment
            Boolean exceeded = loopCountMap.get(handlerName).increment();
            if(exceeded){
                Integer max = loopCountMap.get(handlerName).max;
                throw new TriggerHandlerException('Maximum Loop count of your trigger is '+String.valueOf(max)+' Reached in  '+handlerName);
            }
        }
    }
    // make sure this trigger should contunie to run
    private Boolean validateRun(){
        // How can I identify whether it is called from trigger context
        if(this.context == null && !this.isTriggerExecuting){
           throw new TriggerHandlerException('Trigger Handler called from outside which is not allowed , contact your Product Owner to accept');
        }
        // Is Current Trigger Handler is not in bypass state
        Boolean isBypassed = bypassHandlers.contains(this.getHandlerName());
        return !isBypassed; 
    }
    // To extract the class Name from the Insatnce of the class 
    private String getHandlerName(){
        // THIS --> CLASSNAME:[ClassVariable=value , ClassVaribles  = {}]
        String className = String.valueOf(this).substring(0,String.valueof(this).indexOf(':'));
        return className;
    }

    // Set BypassHandler Values 
    public static void bypass(String handlerName){
        bypassHandlers.add(handlerName);
    }
    // He need to clear the bypass
    public static void clearBypass(String handlerName){
        bypassHandlers.remove(handlerName);
    }
    // clear all bypass handlers 
    public static void clearAllBypasses(){
        bypassHandlers.clear();
    }

    // Inner Classes 
    private class LoopCount{
        private Integer max;
        private Integer count;

         // We need default values 
        public LoopCount(){
            this.max = 2;
            this.count = 0;
        }
        public LoopCount(Integer maxCount){
            this.max = maxCount;
            this.count = 0;
        }
        // Increment we need to based on calling
        public boolean increment(){
            this.count++; // this.count = this.count+1;
            return this.exceeded();
        }
        // Know the Reach limits 
        public Boolean exceeded(){
            return (this.max >=0 && this.count > this.max);
        }
        // we need to set ,maximum count 
        public void setMax(Integer max){
            this.max = max;
        }
        //get to know the current execution value
        public Integer getCount(){
            return this.count;
        }
        //! Erorr mechanim when count reachs maximum 
    }

    private enum TriggerContext{
        BEFORE_INSERT , BEFORE_UPDATE , BEFORE_DELETE,
        AFTER_INSERT , AFTER_UPDATE,AFTER_DELETE , AFTER_UNDELETE
    }

    // Define Exception class to handle custom exception messages 
    public class TriggerHandlerException extends Exception{}
}