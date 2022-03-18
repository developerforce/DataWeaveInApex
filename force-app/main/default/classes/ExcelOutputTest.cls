@IsTest
public with sharing class ExcelOutputTest {

    @TestSetup
    static void init() {
        // Test contacts
        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(FirstName='John', LastName='Doe'));
        contacts.add(new Contact(FirstName='Jane', LastName='Doe'));
        contacts.add(new Contact(FirstName='John', LastName='Foe'));
        contacts.add(new Contact(FirstName='Jane', LastName='Foe'));
        contacts.add(new Contact(FirstName='John', LastName='Goe'));
        insert contacts;
    }

    // Uses the ./src/dw/excelOutput.dwl script to log a message
    @IsTest
    public static void runtimeDataWeaveError() {
             
        List<Contact> data = [SELECT FirstName, LastName FROM Contact ORDER BY LastName ASC LIMIT 5];
        System.assert(!data.isEmpty(), 'Contacts required for input data');

        Dataweave.Script dwscript = DataWeave.Script.createScript('excelOutput');
        try {
            DataWeave.Result result = dwscript.execute(new Map<String, Object>{ 'records' => data });
            
            string output = result.getValueAsString();
                
            System.assert(false, 'application/xlsx is not currently an expected output type');
        } catch (System.DataWeaveScriptException ex) {
            System.assert(ex.getMessage().contains('Unknown content type `application/xlsx`'));
        }
    }
}
