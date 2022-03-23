/**
 * @description Class provides a re-usable, dynamic and typesafe way to
 * translate an API's JSON response into a list of sObjects.
 */
public with sharing class DWJsonToSObjectsList {
    // incomingJson can be any json string
    private String incomingJson;
    // keyMap is a JSON formatted key:value map where the left side is the name of the
    // key in the incomingJson object, and the right side is the name of the key in
    // the returning json.
    private String keyMap;

    /**
     * @description        full constructor
     * @param incomingJson json string
     * @param keyMap       Map representing JSON key names in the input and output json strings
     */
    public DWJsonToSObjectsList(String incomingJson, String keyMap) {
        this.incomingJson = incomingJson;
        this.keyMap = keyMap;
    }

    /**
     * @description                     Constructor that defines the mapping necessary to
     * translate the incoming json to sObjects from custom metadata
     * @param incomingJson              The incoming JSON to translate
     * @param dataweaveMappingMDTRecord A Dataweave_Mapping__mdt record. This is used to query
     * the Dataweave_Key_Mapping__mdt records.
     */
    public DWJsonToSObjectsList(
        String incomingJson,
        Dataweave_Mapping__mdt dataweaveMappingMDTRecord
    ) {
        this(
            incomingJson,
            fetchMappingFromCustomMetadata(dataweaveMappingMDTRecord)
        );
    }

    /**
     * @description       Given a valid string representation of an sObject
     * this method utilizes class variables of json and keyMap to translate
     * the input json's keys into those specified in the mapping object.
     * @param sObjectType This is the type of List<sObject> to return.
     * @return            `List<sObject>`
     */
    public String translate() {
        Map<String, Object> parameters = new Map<String, Object>();
        parameters.put('mapping', keyMap);
        parameters.put('incomingJson', incomingJson);
        Dataweave.Script script = Dataweave.Script.createScript(
            'json2sObjects'
        );
        DataWeave.Result result = script.execute(parameters);
        return result.getValueAsString();
    }

    /**
     * @description       Method extends the translate method by deserializing the resulting json
     * to a List<sObject>. This method relies on Apex's ability to seamlessly cast from a list of
     * concrete sObjects to a list of generic sObjects. This allows the calling code to cast the
     * resulting list to a List<sObject> to a list of concrete sObject records.
     * @param sObjectType String representation of the concrete sObject type to be returned.
     * @return            `List<sObject>`
     */
    public List<sObject> translateToSObjects(String sObjectType) {
        // construct a Type object reflecting a List of the concrete sObject type specified
        Type dynamicListType = Type.forName('List<' + sObjectType + '>');
        // This line is a doozy, and the bulk of the work happens here.
        // translate is called to get the json string, and then the resulting json is
        // deserialized into a List<sObject> because this list was created
        // with a concrete sObject type, and then cast to a generic sObject list
        // the type system is able to re-cast to a concrete sObject list at the
        // site of the calling code.
        return (List<sObject>) JSON.deserialize(translate(), dynamicListType);
    }

    ///
    /// Helper methods
    ///

    /**
     * @description               Given a Dataweave_Mapping__mdt record, it constructs
     * a JSON string representing the mapping between the incoming json and the sobject requested.
     * @param dataweaveMappingMDT
     * @return                    `String`
     */
    private static String fetchMappingFromCustomMetadata(
        Dataweave_Mapping__mdt dataweaveMappingMDT
    ) {
        List<Dataweave_Key_Mapping__mdt> mappings = [
            SELECT incoming_key__c, outgoing_key__c
            FROM Dataweave_Key_Mapping__mdt
            WHERE Dataweave_Mapping__r.id = :dataweaveMappingMDT.id
            WITH SECURITY_ENFORCED
        ];
        Map<String, String> results = new Map<String, String>();

        // Look, this is a hack. Don't do this in production code.
        // In real code, in the real world, you should dependency inject
        // an object responsible for doing the metadata query below and
        // use the stub API to mock the response.
        // I'm doing this here so as to not introduce a bunch of code
        // just to illustrate how you can DW arbitrary JSON into a list
        // of sObjects, declaratively with custom metadata. Don't hate me.
        // Specifically don't do this whole Test.isRunningTest() thing.
        // START HACKTASTIC CODE.
        if (Test.isRunningTest()) {
            results = DWJsonToSObjectsListTest.getManualMapping();
        } else {
            for (Dataweave_key_mapping__mdt mapping : mappings) {
                results.put(mapping.incoming_key__c, mapping.outgoing_key__c);
            }
        }
        // END HACKTASTIC CODE.

        return JSON.serialize(results);
    }
}
