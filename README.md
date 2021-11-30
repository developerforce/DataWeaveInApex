# DataWeave In Apex
Examples for working with DataWeave scripts from Apex.

This functionality is [currently in pilot](https://trailhead.salesforce.com/trailblazer-community/groups/0F94S000000kGtKSAU?tab=discussion). Please reach out to your Account Executive (AE) if you would like to be included in the pilot.


## Basic Setup

1. Create a scratch org using a DevHub that has been activated for the DataWeave in Apex pilot
2. Push the source to the scratch org
3. Push the Metadata Source for the DataWeave scripts  
`sfdx force:mdapi:deploy -d ./src --wait=-1`

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

See [`ObjectProcessingTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/force-app/main/default/classes/ObjectProcessingTest.cls) for an example of handling an exception orginating from a DataWeave script execution

### Multiple Inputs

See [`MultipleInputsTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/force-app/main/default/classes/MultipleInputsTest.cls) for an example of handling multiple inputs to a single DataWeave Script.

### Built in Functions

See [`PluralizeTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/force-app/main/default/classes/PluralizeTest.cls) for an example of using DataWeave built in String functions