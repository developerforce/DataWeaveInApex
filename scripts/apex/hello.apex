// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

DataWeave.Script dwscript = DataWeave.Script.createScript('helloworld');
DataWeave.Result result = dwscript.execute(new Map<String, Object>());
system.debug('DW Script output: ' + result.getValueAsString());