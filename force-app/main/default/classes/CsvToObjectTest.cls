@IsTest
public with sharing class CsvToObjectTest {
    
    // Uses the ./src/dw/csvToCustomObject.dwl script to convert from a CSV static resource to objects
    @IsTest
    public static void convertCsvToObjects() {
        // Load CSV data as a blob from static resource
        Blob data = [Select Body 
            FROM 
            StaticResource 
            WHERE 
            Name = 'contacts' 
            LIMIT 1].Body;

        string scriptName = 'csvToCustomObject';
        DataWeave.Script dwscript = DataWeave.Script.createScript(scriptName);
        DataWeave.Result dwresult = dwscript.execute(new Map<String, Object>{'records' => data.toString()});

        // Note that CsvData here is an Apex POTATO (Apex equivalent of a POJO)
        List<CsvData> results = (List<CsvData>)dwresult.getValue();
        System.assertEquals(51, results.size(), 'The static resource contacts.csv has 51 rows of data (less headers)');
        for(CsvData c : results) {
            Assert.isNotNull(c.FirstName);
            Assert.isNotNull(c.LastName);
            Assert.isNotNull(c.Company);
            Assert.isNotNull(c.Address);
            
            if(c.FirstName=='Donette' && c.LastName=='Foller') {
                Assert.areEqual('34 Center St\r\n#42', c.Address);
            }
        }
    }
}