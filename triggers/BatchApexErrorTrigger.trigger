trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
	List<BatchLeadConvertErrors__c> errors = new List<BatchLeadConvertErrors__c>();
        for (BatchApexErrorEvent event : Trigger.New){
            errors.add(new BatchLeadConvertErrors__c(AsyncApexJobId__c = event.AsyncApexJobId,
                             Records__c = event.JobScope,
                            StackTrace__c = event.StackTrace));
        }
    insert errors;
}