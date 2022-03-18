@isTest
public class DWJsonToSObjectsListTest {
    private static final String JSONTESTBODY = '[{"id":1,"first_name":"Madison","last_name":"Abrahmer","email":"mabrahmer0@vkontakte.ru","gender":"Male","ip_address":"208.229.61.227","source":"jp.co.google.Zaam-Dox","country":"ID","StreetAddress":"80 Corry Hill","city":"Krajan","state":"IN","postalCode":"26603"},{"id":2,"first_name":"Donnamarie","last_name":"Maudlin","email":"dmaudlin1@google.co.jp","gender":"Male","ip_address":"80.143.25.159","source":"com.cargocollective.Temp","country":"SI","StreetAddress":"4 Anniversary Way","city":"Mežica","state":"IN","postalCode":"2392"}]';

    @isTest
    static void jsonToSObjectManualMappingPositive() {
        Map<String, String> mapping = getManualMapping();
        DWJsonToSObjectsList converter = new DWJsonToSObjectsList(
            DWJsonToSObjectsListTest.JSONTESTBODY,
            JSON.serialize(mapping)
        );
        Test.startTest();
        List<Contact> contacts = (List<Contact>) converter.translateToSObjects(
            'Contact'
        );
        Test.stopTest();

        System.assertEquals(
            2,
            contacts.size(),
            'Expected a fixed json array of two contacts to be converted to two contact sObjects'
        );
        for (Contact cont : contacts) {
            System.assertEquals(
                null,
                cont.id,
                'Expected the convert to ignore the ID field on the incoming object'
            );
            for (String mappingValues : mapping.values()) {
                System.assertNotEquals(
                    cont.get(mappingValues),
                    null,
                    'Expected the converted sObject to have a value for the mapped field'
                );
            }
        }
    }

    @isTest
    static void jsonToSObjectCustomMetadataPositive() {
        Dataweave_Mapping__mdt mapping = new Dataweave_Mapping__mdt();
        mapping.masterLabel = 'test';
        mapping.developerName = 'test';
        mapping.sObject_type__c = 'account';

        DWJsonToSObjectsList converter = new DWJsonToSObjectsList(
            DWJsonToSObjectsListTest.JSONTESTBODY,
            mapping
        );
        Test.startTest();
        List<Contact> contacts = (List<Contact>) converter.translateToSObjects(
            'Contact'
        );
        Test.stopTest();

        System.assertEquals(
            2,
            contacts.size(),
            'Expected a fixed json array of two contacts to be converted to two contact sObjects'
        );
        for (Contact cont : contacts) {
            System.assertEquals(
                null,
                cont.id,
                'Expected the convert to ignore the ID field on the incoming object'
            );
            for (String mappingValues : getManualMapping().values()) {
                System.assertNotEquals(
                    cont.get(mappingValues),
                    null,
                    'Expected the converted sObject to have a value for the mapped field'
                );
            }
        }
    }

    /// Helper methods
    public static Map<String, String> getManualMapping() {
        Map<String, String> mapping = new Map<String, String>();
        mapping.put('first_name', 'firstName');
        mapping.put('last_name', 'lastName');
        mapping.put('email', 'email');
        mapping.put('country', 'mailingCountry');
        mapping.put('StreetAddress', 'mailingStreet');
        mapping.put('city', 'mailingCity');
        mapping.put('state', 'mailingState');
        mapping.put('postalCode', 'mailingPostalCode');
        return mapping;
    }
}
