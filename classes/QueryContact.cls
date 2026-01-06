public class QueryContact {
  public static Id getContactID(String lastName, String title) {
    try {
      Contact myContact = Database.query(
        'SELECT ID, Name FROM Contact WHERE lastName = :lastName AND title = :title LIMIT 1'
      );
      return myContact.Id;
    } catch (Exception ex) {
      return null;
    }
  }
  public static Id getContactIDWithBinds(Map<String, Object> bindVars) {
    //do not modify any code above this line
    //implement the logic that will use bindVars to retrieve the contact's ID
    /*String lastName = 'Acme Inc.';
    String title = 'title';
    bindVars = new Map<String, Object>{'lastName' => lastName, 'title' => title};*/
      String queryString =
        'SELECT ID ' +
        'FROM Contact ' +
        'WHERE lastName = :lastName AND title =: title LIMIT 1';
    List<Contact> contacts = Database.queryWithBinds(
        queryString,
        bindVars,
        AccessLevel.USER_MODE
    );
      return contacts[0].Id;
      
  }
}