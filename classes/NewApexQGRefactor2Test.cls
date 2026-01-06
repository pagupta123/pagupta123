@IsTest
public class NewApexQGRefactor2Test {
    @isTest
    private static void testExecute(){
        String result = NewApexQGRefactor.execute();
        system.assertEquals('NewApexQGRefactor5', result);
    }
}