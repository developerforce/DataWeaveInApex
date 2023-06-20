@IsTest
public with sharing class ObjectProcessingTest {

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

    // Uses the /dw/objectProcessing.dwl script to log a message
    @IsTest
    public static void passSObjectsToDataWeave() {
        List<Contact> data = [SELECT FirstName, LastName FROM Contact ORDER BY LastName ASC LIMIT 5];
        Assert.isFalse(data.isEmpty(), 'Contacts required for input data');

        DataWeave.Script script = DataWeave.Script.createScript('objectProcessing');
        DataWeave.Result result = script.execute(new Map<String, Object>{ 'records' => data });
        
        String output = result.getValueAsString();
               
        System.debug(output);

        Assert.areEqual(339, output.length());

        output = output.normalizeSpace();

        Assert.isTrue(output.contains('"lastName": "Doe"'));
        Assert.isTrue(output.contains('"lastName": "Foe"'));
        Assert.isTrue(output.contains('"lastName": "Goe"'));
    }

    @IsTest
    public static void jsonSerializeForComparrison() {
        List<Contact> data = [SELECT FirstName, LastName FROM Contact ORDER BY LastName ASC LIMIT 5];

        List<UserData> ud = new List<UserData>();

        for(Contact c : data) {
            UserData u = new UserData();
            u.firstName = c.FirstName;
            u.lastName = c.lastName;
            ud.add(u);
        }
        Map<String, List<UserData>> users = new Map<String, List<UserData>>();
        users.put('users', ud);

        String output = JSON.serializePretty(users);

        System.debug(output);

        Assert.areEqual(298, output.length());

        output = output.normalizeSpace();

        Assert.isTrue(output.contains('"lastName" : "Doe"'));
        Assert.isTrue(output.contains('"lastName" : "Foe"'));
        Assert.isTrue(output.contains('"lastName" : "Goe"'));
    }

    class UserData {
        public String firstName;
        public String lastName;
    }

    // Uses the /dw/csvToContacts.dwl script to convert the csv data to Contact sObjects
    @IsTest
    public static void sObjectsFromDataWeave() {
        // CSV data for Contacts
        String inputCsv = 'first_name,last_name,email\nCodey,"The Bear",codey@salesforce.com'; 
        DataWeave.Script dwscript = DataWeave.Script.createScript('csvToContacts');
        DataWeave.Result dwresult = dwscript.execute(new Map<String, Object>{'records' => inputCsv});
        List<Contact> results = (List<Contact>)dwresult.getValue();

        Assert.areEqual(1, results.size());
        Contact codeyContact = results[0];
        Assert.areEqual('Codey',codeyContact.FirstName);
        Assert.areEqual('The Bear',codeyContact.LastName);
        Assert.areEqual('codey@salesforce.com',codeyContact.Email);
    }

}
