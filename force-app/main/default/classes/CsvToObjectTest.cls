@IsTest
public with sharing class CsvToObjectTest {
    
    // Uses the /dw/csvToCustomObject.dwl script to convert from a CSV static resource to objects
    @IsTest
    public static void convertCsvToObjects() {
        // Load CSV data as a blob from static resource
        Blob data = [SELECT Body 
            FROM 
            StaticResource 
            WHERE 
            Name = 'contacts' 
            LIMIT 1].Body;

        DataWeave.Script script = new DataWeaveScriptResource.csvToCustomObject();
        DataWeave.Result dwresult = script.execute(new Map<String, Object>{'records' => data.toString()});

        // Note that CsvData here is an Apex POTATO (Apex equivalent of a POJO)
        List<CsvData> results = (List<CsvData>)dwresult.getValue();
        System.assertEquals(51, results.size(), 'The static resource contacts.csv has 51 rows of data (less headers)');
        for(CsvData c : results) {
            Assert.isNotNull(c.FirstName);
            Assert.isNotNull(c.LastName);
            Assert.isNotNull(c.Company);
            Assert.isNotNull(c.Address);
            
            if(c.FirstName=='Donette' && c.LastName=='Foller') {
                // The line ending characters of the OS that uploaded the StaticResource can affect the encoding
                Assert.isTrue(c.Address == '34 Center St\n#42' || c.Address == '34 Center St\r\n#42');
            }
        }
    }

    // Uses the /dw/csvToCustomObject.dwl script to convert from a large CSV static resource to objects
    @IsTest
    public static void convertLargeCsvToObjects() {
        // Load CSV data as a blob from static resource
        Blob data = [SELECT Body 
            FROM 
            StaticResource 
            WHERE 
            Name = 'contactsLarge' 
            LIMIT 1].Body;

        System.debug(LoggingLevel.Warn, 'Before parse Heap: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
        System.debug(LoggingLevel.Warn, 'Before parse CPU: ' + Limits.getCpuTime() + '/' + Limits.getLimitCpuTime());

        DataWeave.Script script = new DataWeaveScriptResource.csvToCustomObject();
        DataWeave.Result dwresult = script.execute(new Map<String, Object>{'records' => data.toString()});

        System.debug(LoggingLevel.Warn, 'After parse Heap: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
        System.debug(LoggingLevel.Warn, 'After parse CPU: ' + Limits.getCpuTime() + '/' + Limits.getLimitCpuTime());

        List<CsvData> results = (List<CsvData>)dwresult.getValue();
        Assert.areEqual(18000, results.size());

        System.debug('Heap: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
        
        for(CsvData c : results) {
            Assert.isNotNull(c.FirstName);
            Assert.isNotNull(c.LastName);
            Assert.isNotNull(c.Company);
            Assert.isNotNull(c.Address);
            
            if(c.FirstName=='Vinnie' && c.LastName=='Martellini') {
                Assert.areEqual('Schulist, Schneider and Gutkowski', c.Company);
            }
        }

        System.debug('Heap: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
    }
}