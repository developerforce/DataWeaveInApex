@IsTest
public with sharing class CsvToJsonConversionTest {
    
    // Uses the ./src/dw/csvtojson.dwl script to convert from a CSV static resource to JSON
    @IsTest
    public static void convertCsvToJsonContacts() {
        // Load CSV data as a blob from static resource
        Blob data = [Select Body 
            FROM 
            StaticResource 
            WHERE 
            Name = 'contacts' 
            LIMIT 1].Body;

        string scriptName = 'csvtojson';
        dataweave.Script dwscript = DataWeave.Script.createScript(scriptName);
        string scriptNameReported = dwscript.toString();
        System.assertEquals(scriptName, scriptNameReported);

        DataWeave.Result result = dwscript.execute(new Map<String, Object>{'data' => data.toString()});

        string jsonResult = result.getValueAsString();
        //system.debug('JSON output '+ jsonResult );

        List<Contact> contacts = (List<Contact>)JSON.deserialize(jsonResult, List<Contact>.class);
        System.assertEquals(51, contacts.size(), 'The static resource contacts.csv has 51 rows of data (less headers)');
        for(Contact c : contacts) {
            System.assertNotEquals(null, c.FirstName);
            System.assertNotEquals(null, c.LastName);
        }
    }

    // Uses the ./src/dw/csvSeparatorTojson.dwl script to convert from a CSV with ; delimiters to JSON
    @IsTest
    public static void csvSeparatorToJson() {
        // Note the use of the ; separator rather than ,
        Map<String, Object> args = new Map<String, Object>{ 'records' => '1;2\na;b' };

        string scriptName = 'csvSeparatorTojson';
        dataweave.Script dwscript = DataWeave.Script.createScript(scriptName);
        string scriptNameReported = dwscript.toString();
        System.assertEquals(scriptName, scriptNameReported);

        DataWeave.Result result = dwscript.execute(args);

        string jsonResult = result.getValueAsString();
        system.debug('JSON output '+ jsonResult );

        System.assert(jsonResult.contains('"1": "a",'), 'Expected first record header and value.');
        System.assert(jsonResult.contains('"2": "b"'), 'Expected first record header and second value');
    }
}