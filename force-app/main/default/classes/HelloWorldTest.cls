@IsTest
public with sharing class HelloWorldTest {

    // Uses the ./src/dw/helloworld.dwl script to log a message
    @IsTest
    public static void helloWorld() {
        Dataweave.Script dwscript = DataWeave.Script.createScript('helloworld');
        DataWeave.Result result = dwscript.execute(new Map<String, Object>());
        System.assertEquals('"Hello World"', result.getValueAsString(), 'Log output becomes the value when there are no other results');
        // W-10169596 Known Issue. getValueAsString should be idempotent
        System.assertEquals('', result.getValueAsString(), 'W-10169596 bug where only first call works');
    }
}