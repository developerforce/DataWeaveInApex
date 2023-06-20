@IsTest
public with sharing class JsonDateFormatTest {

    @TestSetup
    static void init() {
        // Test contacts
        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(FirstName='John', LastName='Doe'));
        insert contacts;
    }

    // Uses the /dw/jsonDateFormat.dwl script to transform sObjects date format
    @IsTest
    public static void jsonDateFormat() {

        List<Contact> data = [SELECT FirstName, LastName, CreatedDate FROM Contact ORDER BY LastName ASC LIMIT 5];
        Assert.isFalse(data.isEmpty(), 'Contacts required for input data');

        Dataweave.Script dwscript = DataWeave.Script.createScript('jsonDateFormat');
        DataWeave.Result result = dwscript.execute(new Map<String, Object>{ 'records' => data });
       
        // Note that DW uses Java 8 java.time.format, so uuuu is the year. vs. yyyy for Apex. 
        String expected = '{\n'+
        '  "users": [\n'+                                                                                                                      
        '    {\n'+
        '      "firstName": "John",\n'+
        '      "lastName": "Doe",\n'+
        '      "createdDate": "' + data[0].CreatedDate.formatGMT('hh:mm:ss a, MMMM dd, yyyy') + '"\n'+
        '    }\n'+
        '  ]\n'+
        '}';

        Assert.areEqual(expected, result.getValueAsString(), 'Expected custom DateTime format in UTC');
    }
}