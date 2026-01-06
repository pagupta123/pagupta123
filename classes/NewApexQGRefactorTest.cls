@IsTest
public class NewApexQGRefactorTest {
    @isTest
    private static void testExecute(){
        String result = NewApexQGRefactor.execute();
        system.assertEquals('NewApexQGRefactor23', result);
    }
}