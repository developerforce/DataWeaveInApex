@IsTest
public with sharing class CsvToJsonConversionTest {
    
    // Uses the /dw/csvToJson.dwl script to convert from a CSV static resource to JSON
    @IsTest
    public static void convertCsvToJsonContacts() {
        // Load CSV data as a blob from static resource
        Blob data = [SELECT Body 
            FROM 
            StaticResource 
            WHERE 
            Name = 'contacts' 
            LIMIT 1].Body;

        DataWeave.Script script = new DataWeaveScriptResource.csvToJson();
        String scriptNameReported = script.toString();
        System.assertEquals('csvToJson', scriptNameReported);

        DataWeave.Result result = script.execute(new Map<String, Object>{'data' => data.toString()});
        String jsonResult = result.getValueAsString();

        List<Contact> contacts = (List<Contact>)JSON.deserialize(jsonResult, List<Contact>.class);
        System.assertEquals(51, contacts.size(), 'The static resource contacts.csv has 51 rows of data (less headers)');
        for(Contact c : contacts) {
            System.assertNotEquals(null, c.FirstName);
            System.assertNotEquals(null, c.LastName);
            System.assertNotEquals(null, c.MailingStreet);
            
            if(c.FirstName=='Donette' && c.LastName=='Foller') {
                System.assertEquals('34 Center St\n#42', c.MailingStreet);
            }
        }
    }

    // Uses the /dw/csvSeparatorToJson.dwl script to convert from a CSV with ; delimiters to JSON
    @IsTest
    public static void csvSeparatorToJson() {
        // Note the use of the ; separator rather than ,
        Map<String, Object> args = new Map<String, Object>{ 'records' => '1;2\na;b' };

        DataWeave.Script script = new DataWeaveScriptResource.csvSeparatorToJson();
        String scriptNameReported = script.toString();
        Assert.areEqual('csvSeparatorToJson', scriptNameReported);

        DataWeave.Result result = script.execute(args);

        String jsonResult = result.getValueAsString();
        system.debug('JSON output '+ jsonResult );

        Assert.isTrue(jsonResult.contains('"1": "a",'), 'Expected first record header and value.');
        Assert.isTrue(jsonResult.contains('"2": "b"'), 'Expected first record header and second value');
    }

    // Uses the /dw/csvToJsonBasic.dwl script to convert from a CSV to JSON with no extra conversion
    @IsTest
    public static void convertCsvToJsonBasic() {
        String csvPayload = 'first_name,last_name,company,address\n' +
            'Abel,Maclead,"Rousseaux, Michael Esq","6649 N Blue Gum St,\n' +
            'New Orleans"';

        DataWeave.Script script = new DataWeaveScriptResource.csvToJsonBasic();
        DataWeave.Result result = script.execute(new Map<String, Object>{'payload' => csvPayload});

        String jsonResult = result.getValueAsString();
        Assert.areNotEqual(0, jsonResult.trim().length(), 'Expected to have JSON output from DW script');
        System.debug(jsonResult);
        /*[
            {
                "first_name": "Abel",
                "last_name": "Maclead",
                "company": "Rousseaux, Michael Esq",
                "address": "6649 N Blue Gum St,\nNew Orleans"
            }
          ]*/

        List<Object> jsonList = (List<Object>)JSON.deserializeUntyped(jsonResult);
        Map<String, Object> jsonMap = (Map<String, Object>) (jsonList[0]);
        Assert.areEqual('Abel', jsonMap.get('first_name'));
        Assert.areEqual('Maclead', jsonMap.get('last_name'));
        Assert.areEqual('Rousseaux, Michael Esq', jsonMap.get('company'));
        Assert.areEqual('6649 N Blue Gum St,\nNew Orleans', jsonMap.get('address'));
    }
}