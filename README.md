# DataWeaveInApex
Examples for working with DataWeave scripts from Apex (currently in pilot)


## Basic Setup

1. Create a scratch org using a DevHub that has been activated for the DataWeave in Apex pilot
2. Push the source to the scratch org
3. Push the Metadata Source for the DataWeave scripts
sfdx force:mdapi:deploy -d ./src --wait=-1

## Examples

### Hello World

See [`HelloWorldTest.cls`](https://github.com/developerforce/DataWeaveInApex/blob/main/HelloWorldTest.cls) for a minimal version for calling a DataWeave script from Apex that only logs "Hello World".

