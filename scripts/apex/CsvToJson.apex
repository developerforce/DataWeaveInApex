string csvPayload = 'first_name,last_name,company,address\n' +
            'Abel,Maclead,"Rousseaux, Michael Esq","6649 N Blue Gum St,\n' +
            'New Orleans"';
System.debug(csvPayload);

string scriptName = 'csvToJsonBasic';
DataWeave.Script dwscript = DataWeave.Script.createScript(scriptName);

DataWeave.Result result = dwscript.execute(new Map<String, Object>{'payload' => csvPayload});
string jsonResult = result.getValueAsString();
System.debug(jsonResult); 