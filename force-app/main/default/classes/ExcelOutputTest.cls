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
             
        List<Contact> data = [SELECT FirstName, LastName FROM Contact ORDER BY LastName ASC LIMIT 1];
        Assert.isFalse(data.isEmpty(), 'Contacts required for input data');

        DataWeave.Script script = new DataWeaveScriptResource.excelOutput();
        try {
            DataWeave.Result result = script.execute(new Map<String, Object>{ 'records' => data });
            
            String output = result.getValueAsString();
                
            Assert.fail('application/xlsx is not currently an expected output type');
        } catch (System.DataWeaveScriptException ex) {
            Assert.isTrue(ex.getMessage().contains('Unknown content type `application/xlsx`'));
        }
    }
}
