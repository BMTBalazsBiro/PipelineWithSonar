/**
 * Created by BalazsBiro on 10/05/2023.
 */

@IsTest
private class TestClass {
    @IsTest
    static void testBehavior() {
        ClassA.print();
        System.debug('ClassA.print() = ' + ClassA.print());
    }
}