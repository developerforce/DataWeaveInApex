@IsTest
public with sharing class ExceptionHandlingTest {

    // Uses the ./src/dw/error.dwl script to log a message
    @IsTest
    public static void runtimeDataWeaveError() {
                
        Dataweave.Script dwscript = DataWeave.Script.createScript('error');
        try {
            DataWeave.Result result = dwscript.execute(new Map<String, Object>());
            System.assert(false, 'Exception expected');
        } catch (System.DataWeaveScriptException ex) {
            System.debug(LoggingLevel.Error, ex);
            System.assert(ex.getMessage().startsWith('Division by zero'));
            System.debug('Message:' + ex.getMessage());
            System.debug('LineNumber:' + ex.getLineNumber());
            System.debug('StackTraceString:' + ex.getStackTraceString());
            System.debug('TypeName:' + ex.getTypeName());
        }
    }
}
