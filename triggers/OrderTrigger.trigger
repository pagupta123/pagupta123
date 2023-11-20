trigger OrderTrigger on Order (after insert) {

  if(Trigger.isAfter && Trigger.isInsert){
      orderTriggerHandler.afterInsert(Trigger.New);
  }





}