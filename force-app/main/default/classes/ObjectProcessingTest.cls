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

    // Uses the ./src/dw/objectProcessing.dwl script to log a message
    @IsTest
    public static void passSObjectsToDataWeave() {
        List<Contact> data = [SELECT FirstName, LastName FROM Contact ORDER BY LastName ASC LIMIT 5];
        System.assert(!data.isEmpty(), 'Contacts required for input data');

        DataWeave.Script script = DataWeave.Script.createScript('objectProcessing');
        DataWeave.Result result = script.execute(new Map<String, Object>{ 'records' => data });
        
        string output = result.getValueAsString();
               
        System.debug(output);

        System.assertEquals(339, output.length());

        output = output.normalizeSpace();

        System.assert(output.contains('"lastName": "Doe"'));
        System.assert(output.contains('"lastName": "Foe"'));
        System.assert(output.contains('"lastName": "Goe"'));
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

        string output = JSON.serializePretty(users);

        System.debug(output);

        System.assertEquals(298, output.length());

        output = output.normalizeSpace();

        System.assert(output.contains('"lastName" : "Doe"'));
        System.assert(output.contains('"lastName" : "Foe"'));
        System.assert(output.contains('"lastName" : "Goe"'));
    }

    class UserData {
        public string firstName;
        public string lastName;
    }

}
