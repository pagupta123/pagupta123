@isTest
private class AnimalLocatorTest {
    @isTest static  void testGetCallout() {
        
        // Create the mock response based on a static resource
        AnimalLocatorMock mock = new AnimalLocatorMock();
       
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Call method to test
        String result = AnimalLocator.getAnimalNameById(1);
        system.assert(result != null);
           
    }   
}