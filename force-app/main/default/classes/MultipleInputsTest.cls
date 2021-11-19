@IsTest
public with sharing class MultipleInputsTest {
    
    // Based on the DW example from https://docs.mulesoft.com/dataweave/2.3/dataweave-cookbook-reference-multiple-inputs
    // Uses the ./src/dw/multipleInputs.dwl script to log a message
    @IsTest
    public static void multipleInputs() {
        Map<String, Object> inputs = new Map<String, Object>();

        inputs.put('payload', '[  {      "type": "book",      "price": 30,      "properties": {        "title": "Everyday Italian",        "author": [          "Giada De Laurentiis"        ],        "year": 2005      }  },  {      "type": "book",      "price": 29.99,      "properties": {        "title": "Harry Potter",        "author": [          "J K. Rowling"        ],        "year": 2005      }  },  {      "type": "book",      "price": 41.12,      "properties": {        "title": "Mule in Action",        "author": [          "David Dossot",          "John D\'Emic"        ],        "year": 2009      }  },  {      "type": "book",      "price": 49.99,      "properties": {        "title": "XQuery Kick Start",        "author": [          "James McGovern",          "Per Bothner",          "Kurt Cagle",          "James Linn",          "Kurt Cagle",          "Vaidyanathan Nagarajan"        ],        "year": 2003      }  },  {      "type": "book",      "price": 39.95,      "properties": {        "title": "Learning XML",        "author": [          "Erik T. Ray"        ],        "year": 2003      }  }]');
        inputs.put('attributes', '{"publishedAfter": 2004}');
        inputs.put('exchangeRate', '{  "USD": [    {"currency": "EUR", "ratio":0.92},    {"currency": "ARS", "ratio":8.76},    {"currency": "GBP", "ratio":0.66}  ]}');
               
        DataWeave.Script dwscript = DataWeave.Script.createScript('multipleInputs');
        DataWeave.Result result = dwscript.execute(inputs);

        string output = result.getValueAsString();
               
        system.debug('xml output'+ output);

        System.assert(output.contains('<author>Giada De Laurentiis</author>'), output);
        System.assert(output.contains('<price currency="ARS">262.80</price>'), output);
    }
}
