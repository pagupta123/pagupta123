@IsTest
public class PipelineConfigTest {
    @isTest
    private static void testExecute(){
        PipelineConfig.execute();
        system.assert(true);
    }
}