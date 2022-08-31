# DataWeave In Apex
Examples for working with DataWeave scripts from Apex.

This functionality is [currently in Dev Preview](https://help.salesforce.com/s/articleView?id=release-notes.rn_apex_DataWeaveInApex_DevPreview.htm&type=5&release=240) in Winter '23. It can be selectively enabled in scratch orgs.


## Basic Setup

1. Create a scratch org with the "DataWeaveInApex" [scratch org feature](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_scratch_orgs_def_file_config_values.htm). See [/config/project-scratch-def.json](/config/project-scratch-def.json#L4) as an example
2. Push the source to the scratch org - requires SFDX CLI [7.151.9+](https://github.com/forcedotcom/cli/blob/main/releasenotes/sfdx/README.md#71511-may-19-2022)


## Examples

### Hello World

See [`HelloWorldTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/force-app/main/default/classes/HelloWorldTest.cls) for a minimal version for calling a DataWeave script from Apex that only logs "Hello World".

### CSV to JSON

The following example is from the Dreamforce `21 [Develop Enterprise Applications with Apex](https://www.salesforce.com/plus/experience/Dreamforce_2021/series/Developer/episode/episode-3/) presentation and starts at the 15 minute mark.

See [`CsvToJsonConversionTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/force-app/main/default/classes/CsvToJsonConversionTest.cls) for an example of transforming CSV data stored in a static resource to a JSON string.

### CSV to JSON - alternative separator

See the `csvSeparatorToJson()` method in [`CsvToJsonConversionTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/force-app/main/default/classes/CsvToJsonConversionTest.cls) for an example of transforming CSV data using `;` as the separator to a JSON string.

### Script error handling

See [`ExceptionHandlingTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/force-app/main/default/classes/ExceptionHandlingTest.cls) for an example of handling an exception orginating from a DataWeave script execution


### Object Processing

See [`ObjectProcessingTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/force-app/main/default/classes/ObjectProcessingTest.cls) for examples of passing objects to and receiving objects from DataWeave scripts.

### Multiple Inputs

See [`MultipleInputsTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/force-app/main/default/classes/MultipleInputsTest.cls) for an example of handling multiple inputs to a single DataWeave Script.

### Built in Functions

See [`PluralizeTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/force-app/main/default/classes/PluralizeTest.cls) for an example of using DataWeave built in String functions

### Dynamic JSON Mapping

See [`DWJsonToSObjectsListTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/force-app/main/default/classes/DWJsonToSObjectsListTest.cls) for the example from TDX '22 of dynamic JSON mapping to sObjects

### JSON DateTime formatting

See [`JsonDateFormatTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/force-app/main/default/classes/JsonDateFormatTest.cls) for an example of custom DateTime formatting in JSON output.