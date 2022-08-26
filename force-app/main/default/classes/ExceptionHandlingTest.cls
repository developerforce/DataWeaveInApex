@IsTest
public with sharing class ExceptionHandlingTest {

    // Uses the /dw/error.dwl script to log a message
    @IsTest
    public static void runtimeDataWeaveError() {
                
        Dataweave.Script dwscript = DataWeave.Script.createScript('error');
        try {
            DataWeave.Result result = dwscript.execute(new Map<String, Object>());
            Assert.fail('Exception expected');
        } catch (System.DataWeaveScriptException ex) {
            System.debug(LoggingLevel.Error, ex);
            Assert.isTrue(ex.getMessage().startsWith('Division by zero'));
            System.debug('Message:' + ex.getMessage());
            System.debug('LineNumber:' + ex.getLineNumber());
            System.debug('StackTraceString:' + ex.getStackTraceString());
            System.debug('TypeName:' + ex.getTypeName());
        }
    }
}
