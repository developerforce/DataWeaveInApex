@IsTest
public with sharing class ExceptionHandlingTest {

    // Uses the /dw/error.dwl script to log a message
    @IsTest
    public static void runtimeDataWeaveError() {
        DataWeave.Script script = new DataWeaveScriptResource.error();
        try {
            DataWeave.Result result = script.execute(new Map<String, Object>());
            Assert.fail('Exception expected');
        } catch (Exception ex) {
            Assert.isInstanceOfType(ex, DataWeaveScriptException.class, 'Exception of type DataWeaveScriptException expected');
            System.debug(LoggingLevel.Error, ex);
            Assert.isTrue(ex.getMessage().startsWith('Division by zero'));
            System.debug('Message:' + ex.getMessage());
            System.debug('LineNumber:' + ex.getLineNumber());
            System.debug('StackTraceString:' + ex.getStackTraceString());
            System.debug('TypeName:' + ex.getTypeName());
        }
    }
}
