@IsTest
public with sharing class ReservedKeywordTest {

    // Uses the /dw/reservedKeywords.dwl script to handle reserved Apex keywords
    @IsTest
    public static void processReservedKeywords() {
        String jsonString = '[{"currency" : "ABC"}]';

        DataWeave.Script script = DataWeave.Script.createScript('reservedKeywords');
        DataWeave.Result result = script.execute(new Map<String, Object>{ 'incomingJson' => jsonString });
        
        String output = result.getValueAsString();
               
        System.debug(output);

        List<JSONResult> results = (List<JSONResult>) JSON.deserialize(output, List<JSONResult>.class);
        Assert.areEqual(1, results.size());
        JSONResult res = results[0];
        system.debug(res);
        Assert.areEqual('ABC', res.currency_x);
    }

    public class JSONResult {
        public String currency_x;
    }

}
