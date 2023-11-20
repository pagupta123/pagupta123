@isTest
private class DailyLeadProcessorTest {

  public static String CRON_EXP = '0 0 0 15 3 ? 2022';
  private static testMethod void testDailyLeadProcessor() {
        List<Lead> leads = new List<Lead>();
        Lead newLead;
        for (Integer i = 0; i < 200; i++) {
            newLead = new Lead(
                lastName = 'Test' + i, company = 'Company A'
            );
           
            
            leads.add(newLead);
        }
               
        insert leads;
        
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('testSchedule',
            CRON_EXP, 
            new DailyLeadProcessor());         
        // Verify the scheduled job has not run yet.
        
        Test.stopTest();
  }

}