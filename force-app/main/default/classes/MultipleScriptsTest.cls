@IsTest
public with sharing class MultipleScriptsTest {
    
    // Based on the DW example from https://docs.mulesoft.com/dataweave/2.3/dataweave-cookbook-reference-multiple-inputs
    // Uses the /dw/multipleInputs.dwl script to log a message
    @IsTest
    public static void multipleScriptCreationsExecutions() {
        for(integer i = 0; i<100; i++) {
            DataWeave.Script script = new DataWeaveScriptResource.helloWorld();
            DataWeave.Result result = script.execute(new Map<String, Object>());
            script = null;
        }
    }

    @IsTest
    public static void multipleScriptExecutions() {
        DataWeave.Script script = new DataWeaveScriptResource.helloWorld();
        for(integer i = 0; i<100; i++) {
            DataWeave.Result result = script.execute(new Map<String, Object>());           
        }
    }

    @IsTest
    public static void multipleSameScriptExecutions() {
        DataWeave.Script script = new DataWeaveScriptResource.helloWorld();
        DataWeave.Script script2 = new DataWeaveScriptResource.helloWorld();
        for(integer i = 0; i<100; i++) {
            DataWeave.Result result = script.execute(new Map<String, Object>());           
            DataWeave.Result result2 = script2.execute(new Map<String, Object>());           
        }
    }

    @IsTest
    public static void multipleDualScriptExecutions() {
        DataWeave.Script script = new DataWeaveScriptResource.helloWorld();
        DataWeave.Script script2 = new DataWeaveScriptResource.objectProcessing();

        List<Contact> data = new List<Contact>();
        data.add(new Contact(FirstName='John', LastName='Goe'));
        
        for(integer i = 0; i<100; i++) {
            DataWeave.Result result = script.execute(new Map<String, Object>()); 
            DataWeave.Result result2 = script2.execute(new Map<String, Object>{ 'records' => data });           
        }
    }
}


        