public class AddPrimaryContact implements Queueable {
    
    private Contact contact;
    private String stateCode;
    
    public AddPrimaryContact(Contact contact, String stateCode) {
        this.contact = contact;
        this.stateCode = stateCode;
    }
    public void execute(QueueableContext context) {
        List<Contact> contactsToInsert = new List<Contact>();
        Contact newContact;
        List<Account> accounts = [select id from account where billingstate = :stateCode Limit 200];
        for (Account account : accounts) {
          
          newContact = contact.clone(false, false, false, false);
          newContact.accountId = account.id;
          contactsToInsert.add(newContact);
          // perform other processing or callout
        }
        insert contactsToInsert;
    }

}