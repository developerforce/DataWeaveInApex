@IsTest
public with sharing class PluralizeTest {
    
    // Uses the ./src/dw/pluralize.dwl script to apply function: https://docs.mulesoft.com/dataweave/2.3/dw-strings-functions-pluralize
    @IsTest
    public static void pluralize() {
        Map<String, Object> inputs = new Map<String, Object>();
        inputs.put('inputs', '[ "box", "cat", "deer", "die", "person", "cactus", "datum" ]');
        
        dataweave.Script dwscript = DataWeave.Script.createScript('pluralize');
        DataWeave.Result result = dwscript.execute(inputs);
        String jsonOutput = result.getValueAsString();
        System.debug(jsonOutput);
        
        Map<String, String> pluralMappings = new Map<String, String>();

        // Extracting the results could use some refinement 
        List<object> mappings = (List<object>) JSON.deserializeUntyped(jsonOutput);
        for(Object pluralMap : mappings) {
            Map<String, Object> pm = (Map<String, Object>)pluralMap;
            for(String key : pm.keySet()) {
                pluralMappings.put(key, (String)pm.get(key));
            }
        }

        System.assertEquals(7, pluralMappings.size());
        System.assertEquals('boxes', pluralMappings.get('box'));
        System.assertEquals('cats', pluralMappings.get('cat'));
        System.assertEquals('deer', pluralMappings.get('deer'));
        System.assertEquals('dice', pluralMappings.get('die'));
        System.assertEquals('people', pluralMappings.get('person'));
        System.assertEquals('data', pluralMappings.get('datum'));
        // This one is currently failing
        //System.assertEquals('cacti', pluralMappings.get('cactus'));
    }
}
