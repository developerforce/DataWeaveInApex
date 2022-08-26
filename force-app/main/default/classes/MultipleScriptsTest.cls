@IsTest
public with sharing class MultipleScriptsTest {
    
    // Based on the DW example from https://docs.mulesoft.com/dataweave/2.3/dataweave-cookbook-reference-multiple-inputs
    // Uses the ./src/dw/multipleInputs.dwl script to log a message
    @IsTest
    public static void multipleScriptCreationsExecutions() {
        for(integer i = 0; i<100; i++) {
            Dataweave.Script dwscript = DataWeave.Script.createScript('helloworld');
            DataWeave.Result result = dwscript.execute(new Map<String, Object>());
            dwscript = null;
        }
    }

    @IsTest
    public static void multipleScriptExecutions() {
        Dataweave.Script dwscript = DataWeave.Script.createScript('helloworld');
        for(integer i = 0; i<100; i++) {
            DataWeave.Result result = dwscript.execute(new Map<String, Object>());           
        }
    }

    @IsTest
    public static void multipleSameScriptExecutions() {
        Dataweave.Script dwscript = DataWeave.Script.createScript('helloworld');
        Dataweave.Script dwscript2 = DataWeave.Script.createScript('helloworld');
        for(integer i = 0; i<100; i++) {
            DataWeave.Result result = dwscript.execute(new Map<String, Object>());           
            DataWeave.Result result2 = dwscript2.execute(new Map<String, Object>());           
        }
    }

    @IsTest
    public static void multipleDualScriptExecutions() {
        Dataweave.Script dwscript = DataWeave.Script.createScript('helloworld');
        Dataweave.Script dwscript2 = DataWeave.Script.createScript('objectProcessing');

        List<Contact> data = new List<Contact>();
        data.add(new Contact(FirstName='John', LastName='Goe'));
        
        for(integer i = 0; i<100; i++) {
            DataWeave.Result result = dwscript.execute(new Map<String, Object>()); 
            DataWeave.Result result2 = dwscript2.execute(new Map<String, Object>{ 'records' => data });           
        }
    }
}


        