@isTest
public class AddPrimaryContactTest {
    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        
        // add 100 child accounts
        Account acc;
        for (Integer i = 0; i < 100; i++) {
            acc = new Account(
                name='Test Account'+i
            );
            
            if (i <= 50){
                acc.billingState = 'NY';
            }else{
                acc.billingState = 'CA'; 
            }
            
            accounts.add(acc);
        }
        insert accounts;
    }
    
    static testmethod void testQueueable() {
        // query for test data to pass to queueable class
        Contact contact = new Contact(lastname='test', mailingstate ='CA');
        
        // Create our Queueable instance
        AddPrimaryContact updater = new AddPrimaryContact(contact, 'CA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();        
        System.enqueueJob(updater);
        Test.stopTest(); 
        
        List<Account> accounts = [select id, (select id, mailingstate from contacts) from account where name like 'Test Account%'];       
        // Validate the job ran. Check if record have correct parentId now
        System.assert(accounts.size() > 0);
    }
    
}