@IsTest
public with sharing class HelloWorldTest {

    // Uses the /dw/helloworld.dwl script to log a message
    @IsTest
    public static void helloWorld() {
        Dataweave.Script dwscript = DataWeave.Script.createScript('helloworld');
        DataWeave.Result result = dwscript.execute(new Map<String, Object>());
        Assert.areEqual('"Hello World"', result.getValueAsString(), 'Log output becomes the value when there are no other results');
        
        Assert.areEqual('"Hello World"', result.getValueAsString(), 'getValueAsString should be idempotent');
    }
}