@IsTest
private class AccountProcessorTest {
  @IsTest
  private static void testCountContacts() {
   
    List<Account> accountList = new List<Account>();
    Account account = new Account (name = 'Test Account 1');
    accountList.add(account);
    
    account = new Account (name = 'Test Account 2');
    accountList.add(account);
    
    insert accountList;
    
    List<Id> accountIds = new List<Id>();
    for(Account acc : accountList){
        accountIds.add(acc.id);
    }
    
    Test.startTest();
      AccountProcessor.CountContacts(accountIds);
    Test.stopTest();
    // runs callout and check results
   
    accountList = [Select Id, Number_of_Contacts__c
                                    from Account
                                    Where Id IN :accountIds];
    System.assert(accountList.size() > 0);
    
  }
}