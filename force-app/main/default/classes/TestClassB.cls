/**
 * Created by BalazsBiro on 11/05/2023.
 */

@IsTest
private class TestClassB {
    @IsTest
    static void testBehavior() {
        Assert.areEqual('a','a');
        Assert.areEqual('a','a');
    }
}