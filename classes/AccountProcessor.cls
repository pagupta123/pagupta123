public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds){
        List<Account> accountsToUpdate = new List<Account>();
        for(Account account : [Select Id, (select id from contacts) 
                                    from Account
                                    Where Id IN :accountIds]){
            account.Number_of_Contacts__c = account.contacts.size();
            accountsToUpdate.add(account);
        }
        
        update accountsToUpdate;
         
    }

}