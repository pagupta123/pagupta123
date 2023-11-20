global class LeadProcessor implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator(
            'SELECT ID, LeadSource ' +
            'FROM Lead ' 
        );
        // collect the batches of records or objects to be passed to execute
    }
    global void execute(Database.BatchableContext bc, List<Lead> records){
        // process each batch of records
        
        List<Lead> leads = new List<Lead>();
        for (Lead lead : records) {
           lead.LeadSource = 'Dreamforce';
           leads.add(lead);
        }
        update leads;
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
}