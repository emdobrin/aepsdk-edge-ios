The Adobe Experience Platform Edge Network mobile extension allows you to send data to the Adobe Edge Network from a mobile application. This extension allows you to implement Adobe Experience Cloud capabilities in a more robust way, serve multiple Adobe solutions though one network call, and simultaneously forward this information to the Adobe Experience Platform.

# Before starting
## Install the dependent extensions
The AEP Edge Network extension requires the following extensions:
- [AEP Core](https://github.com/adobe/aepsdk-core-ios.git) extension that provides the foundation APIs for any AEP extension, including EventHub and Services.
- [AEP Identity for Edge Network](https://github.com/adobe/aepsdk-edgeidentity-ios.git) extension that provides identity information, such as the Experience Cloud ID (ECID) in XDM IdentityMap format.

As a first step, install and configure the extensions above, then continue with the steps below.

# Add the AEP Edge Network extension to an application

<todo>

## Download and import the Edge extension

### Install extension

These are currently the supported installation options:

#### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

```ruby
# Podfile
use_frameworks!

# for app development, include the following pod
target 'YOUR_TARGET_NAME' do
  pod 'AEPCore'
  pod 'AEPEdge'
  pod 'AEPEdgeIdentity'
end
```

Replace `YOUR_TARGET_NAME` and then, in the `Podfile` directory, type:

```ruby
$ pod install
```

#### [Swift Package Manager](https://github.com/apple/swift-package-manager)

To add the AEPEdge Package to your application, from the Xcode menu select:

`File > Swift Packages > Add Package Dependency...`

Enter the URL for the AEPEdge package repository: `https://github.com/adobe/aepsdk-edge-ios.git`.

When prompted, input a specific version or a range of version for Version rule.

Alternatively, if your project has a `Package.swift` file, you can add AEPEdge directly to your dependencies:

```
dependencies: [
	.package(url: "https://github.com/adobe/aepsdk-core-ios.git", .upToNextMajor(from: "3.0.0")),
	.package(url: "https://github.com/adobe/aepsdk-edge-ios.git", .upToNextMajor(from: "1.0.0")),
	.package(url: "https://github.com/adobe/aepsdk-edgeidentity-ios.git", .upToNextMajor(from: "1.0.0")),
],
targets: [
   	.target(name: "YourTarget",
    		dependencies: ["AEPCore",
                       "AEPEdge",
                       "AEPEdgeIdentity"],
          	path: "your/path")
]
```

#### Binaries

To generate an `AEPEdge.xcframework`, run the following command:

```ruby
$ make archive
```

This generates the xcframework under the `build` folder. Drag and drop all the `.xcframeworks` to your app target in Xcode.

Repeat these steps for each of the required dependencies:
- [AEPCore](https://github.com/adobe/aepsdk-core-ios#binaries)
- [AEPEdgeIdentity](https://github.com/adobe/aepsdk-edgeidentity-ios#binaries)

### Import and register extension

#### Swift

```swift
// AppDelegate.swift

import AEPCore
import AEPEdge
import AEPEdgeIdentity

...
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    MobileCore.registerExtensions([Identity.self,
                                   Edge.self], {
    MobileCore.configureWith(appId: "yourEnvironmentFileID")
  })
  ...
}
```

#### Objective-C

```objectivec
// AppDelegate.h
@import AEPCore;
@import AEPEdge;
@import AEPEdgeIdentity;
```

```objectivec
// AppDelegate.m
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AEPMobileCore registerExtensions:@[AEPMobileEdgeIdentity.class,
                                        AEPMobileEdge.class]
                   completion:^{
    ...
  }];
  [AEPMobileCore configureWithAppId: @"yourEnvironmentFileID"];
  ...
}
```
