@isTest
private class LeadProcessorTest {

  
	private static testMethod void testLeadProcessorBatch() {
        List<Lead> leads = new List<Lead>();
        Lead lead = new Lead(lastName = 'Test', company = 'Company A');
        leads.add(lead);
        
        lead = new Lead(lastName = 'Test 1', company = 'Company A');
        leads.add(lead);
        
        insert leads;
        
        Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca, 200);
        Test.stopTest();
	}

}