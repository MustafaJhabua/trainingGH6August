/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_Guardant_360_SampleTest
{
    @IsTest
    private static void testTrigger()
    {
        // Force the dlrs_Guardant_360_SampleTrigger to be invoked, fails the test if org config or other Apex code prevents this.
        dlrs.RollupService.testHandler(new Guardant_360_Sample__c());
    }
}