String jsonPayload = '[{\r\n\t\t\"name\": \"Apex\",\r\n\t\t\"isSpecial\": false\r\n\t},\r\n\t{\r\n\t\t\"name\": \"Turtles\",\r\n\t\t\"isSpecial\": true\r\n\t}\r\n]';
string scriptName = 'logFilter';
DataWeave.Script dwscript = DataWeave.Script.createScript(scriptName);
DataWeave.Result result = dwscript.execute(new Map<String, Object>{'payload' => jsonPayload});
string jsonResult = result.getValueAsString();
System.debug(jsonResult);