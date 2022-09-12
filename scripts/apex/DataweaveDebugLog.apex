String jsonPayload = '[{\"name\": \"Apex\",\"isSpecial\": false},{\"name\": \"Turtles\",\"isSpecial\": true}]';
string scriptName = 'logFilter';
DataWeave.Script dwscript = DataWeave.Script.createScript(scriptName);
DataWeave.Result result = dwscript.execute(new Map<String, Object>{'payload' => jsonPayload});
string jsonResult = result.getValueAsString();
System.debug(jsonResult);