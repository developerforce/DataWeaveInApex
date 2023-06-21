@IsTest
public with sharing class ExcelOutputTest {

    @TestSetup
    static void init() {
        // Test contacts
        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(FirstName='John', LastName='Doe'));
        insert contacts;
    }

    // Uses the /dw/excelOutput.dwl script to log a message
    @IsTest
    public static void runtimeDataWeaveError() {    
        List<Contact> records = new List<Contact>{
            new Contact(FirstName='John', LastName='Doe')
        };

        DataWeave.Script script = new DataWeaveScriptResource.excelOutput();
        try {
            script.execute(new Map<String, Object>{ 'records' => records });
            
            Assert.fail('Exception expected: application/xlsx is not currently an expected output type');
        } catch (Exception ex) {
            Assert.isInstanceOfType(ex, DataWeaveScriptException.class, 'Exception of type DataWeaveScriptException expected');
            Assert.isTrue(ex.getMessage().contains('Unknown content type `application/xlsx`'));
        }
    }
}
