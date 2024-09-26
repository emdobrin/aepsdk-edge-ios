# Does Edge mobile extension support Edge environments

The Edge extension has built-in support to allow for changing between the Edge Network environments for testing purposes. This feature becomes helpful for testing a new feature or a bug fix prior to a production release.
By default the Edge extension uses the production Edge Network endpoints. It is not recommended to switch the environment in a production application.

The extension can be set up using the "edge.environment" configuration key in order to communicate with the specified Edge Network environment. The supported values are:

| Environment          | Config value (string)|
| ---------------------| -------------------- |
| Production (default) | prod                 |  
| Pre-Production       | pre-prod             |
| Integration          | int                  |

For any other unknown values, the extension defaults to production environment.

## Configuration settings

### Update the environment for testing

In order to update the environment, use the [MobileCore.updateConfigurationWith(configDict: config)](https://github.com/adobe/aepsdk-core-ios/blob/main/Documentation/Usage/MobileCore.md) API with one of the config values enumerated above.

#### Swift

##### Example
```swift
let updatedConfig = ["edge.environment": "pre-prod"]
MobileCore.updateConfigurationWith(configDict: updatedConfig)
```

#### Objective-C

##### Example
```objectivec
NSDictionary *updatedConfig = @{@"edge.environment": @"pre-prod"};
[AEPMobileCore updateConfiguration:updatedConfig];
```

### Cleanup after test

Once you completed your test, you may revert to the default production environment by using one of these options:
* Use the [MobileCore.clearUpdatedConfiguration](https://github.com/adobe/aepsdk-core-ios/blob/main/Documentation/Usage/MobileCore.md) API. Please note that this will clear all the config keys that were previously set programmatically.
* Use the [MobileCore.updateConfigurationWith(configDict: config) API](https://github.com/adobe/aepsdk-core-ios/blob/main/Documentation/Usage/MobileCore.md) API to set the "edge.environment" to "prod".
