# Adobe Experience Platform Edge Network for iOS

## API Reference

| APIs                                           		|
| --------------------------------------------------|
| [extensionVersion](#extensionversion)	            |
| [sendEvent](#sendevent)                           |
| [registerExtension](#registerextension)	          |
| [resetIdentities](#resetidentities)	              |

------

### extensionVersion
Returns the version of the client-side Edge extension.

#### Swift

##### Syntax
```swift
static var extensionVersion: String
```

##### Examples
```swift
let extensionVersion = Edge.extensionVersion
```

#### Objective-C

##### Syntax
```objectivec
+ (nonnull NSString*) extensionVersion;
```

##### Examples
```objectivec
NSString *extensionVersion = [AEPMobileEdge extensionVersion];
```

------

### sendEvent

Sends an Experience event to Adobe Experience Platform Edge Network.

#### Swift

##### Syntax

```swift
static func sendEvent(experienceEvent: ExperienceEvent, _ completion: (([EdgeEventHandle]) -> Void)? = nil)
```

* _experienceEvent_ - the XDM [Experience Event](edge-network-api-reference.md#experienceevent) to be sent to Adobe Experience Platform Edge Network
* _completion_ - optional callback to be invoked when the request is complete, returning the associated [EdgeEventHandle(s)](edge-network-api-reference.md#edgeeventhandle) received from the Adobe Experience Platform Edge Network. It may be invoked on a different thread.

##### Example

```swift
//create experience event from dictionary:
var xdmData : [String: Any] = ["eventType" : "SampleXDMEvent",
                              "sample": "data"]
let experienceEvent = ExperienceEvent(xdm: xdmData)
```
```swift
// example 1 - send the experience event without handling the Edge Network response
Edge.sendEvent(experienceEvent: experienceEvent)
```

```swift
// example 2 - send the experience event and handle the Edge Network response onComplete
Edge.sendEvent(experienceEvent: experienceEvent) { (handles: [EdgeEventHandle]) in
            // handle the Edge Network response
        }
```

#### Objective-C

##### Syntax

```objectivec
+ (void) sendExperienceEvent:(AEPExperienceEvent * _Nonnull) completion:^(NSArray<AEPEdgeEventHandle *> * _Nonnull)completion
```

##### Example
```objectivec
//create experience event from dictionary:
NSDictionary *xdmData = @{ @"eventType" : @"SampleXDMEvent"};
NSDictionary *data = @{ @"sample" : @"data"};
```

```objectivec
// example 1 - send the experience event without handling the Edge Network response
[AEPMobileEdge sendExperienceEvent:event completion:nil];
```
```objectivec
// example 2 - send the experience event and handle the Edge Network response onComplete
[AEPMobileEdge sendExperienceEvent:event completion:^(NSArray<AEPEdgeEventHandle *> * _Nonnull handles) {
  // handle the Edge Network response
}];
```

------

### registerExtension
In iOS, the registration occurs by passing the Edge extension to the `MobileCore.registerExtension` API.

#### Swift

##### Syntax
```swift
static func registerExtensions(_ extensions: [NSObject.Type],
                               _ completion: (() -> Void)? = nil)
```

##### Examples
```swift
import AEPEdge
import AEPEdgeIdentity

...
MobileCore.registerExtensions([Edge.self, Identity.self])
```

#### Objective-C

##### Syntax
```objectivec
+ (void) registerExtensions: (NSArray<Class*>* _Nonnull) extensions
                 completion: (void (^ _Nullable)(void)) completion;
```

##### Example
```objectivec
@import AEPEdge;
@import AEPEdgeIdentity;

...
[AEPMobileCore registerExtensions:@[AEPMobileEdge.class, AEPMobileEdgeIdentity.class] completion:nil];
```

------

### resetIdentities

Resets current state of the AEP Edge extension and clears previously cached content related to current identity, if any.

See [MobileCore.resetIdentities](../mobile-core/mobile-core-api-reference.md#resetidentities) for more details.

------

## Public classes

### XDM Schema

The AEP Edge extension provides the Schema and Property interfaces (Android) / XDMSchema protocol (iOS) that can be used to define the classes associated with your XDM schema in Adobe Experience Platform.

#### Swift

```swift
/// An interface representing a Platform XDM Event Data schema.
public protocol XDMSchema: Encodable {

    /// Returns the version of this schema as defined in the Adobe Experience Platform.
    /// - Returns: The version of this schema
    var schemaVersion: String { get }

    /// Returns the identifier for this schema as defined in the Adobe Experience Platform.
    /// The identifier is a URI where this schema is defined.
    /// - Returns: The URI identifier for this schema
    var schemaIdentifier: String { get }

    /// Returns the identifier for this dataset as defined in the Adobe Experience Platform.
    /// This is a system generated identifier for the Dataset the event belongs to.
    /// - Returns: The  identifier as a String for this dataset
    var datasetIdentifier: String { get }
}
```

------

### EdgeEventHandle

The `EdgeEventHandle` is a response fragment from Adobe Experience Platform Edge Network for a sent XDM Experience Event.
One event can receive none, one or multiple `EdgeEventHandle`(s) as response.

#### Swift

```swift
@objc(AEPEdgeEventHandle)
public class EdgeEventHandle: NSObject, Codable {
    /// Payload type
    @objc public let type: String?

    /// Event payload values
    @objc public let payload: [[String: Any]]?
}
```

Use this class when calling the [sendEvent](#sendevent) API with EdgeCallback.

------

### ExperienceEvent

Experience Event is the event to be sent to Adobe Experience Platform Edge Network.
The XDM data is required for any Experience Event being sent using the Edge extension.

#### Swift

```swift
@objc(AEPExperienceEvent)
public class ExperienceEvent: NSObject {

    /// XDM formatted data, use an `XDMSchema` implementation for a better XDM data injection and format control
    @objc public let xdm: [String: Any]?

    /// Optional free-form data associated with this event
    @objc public let data: [String: Any]?

    /// Adobe Experience Platform dataset identifier, if not set the default dataset identifier set in the Edge Configuration is used
    @objc public let datasetIdentifier: String?

    /// Initialize an Experience Event with the provided event data
    /// - Parameters:
    ///   - xdm:  XDM formatted data for this event, passed as a raw XDM Schema data dictionary.
    ///   - data: Any free form data in a [String : Any] dictionary structure.
    ///   - datasetIdentifier: The Experience Platform dataset identifier where this event should be sent to; if not provided, the default dataset identifier set in the Edge configuration is used
    @objc public init(xdm: [String: Any], data: [String: Any]? = nil, datasetIdentifier: String? = nil) {...}

    /// Initialize an Experience Event with the provided event data
    /// - Parameters:
    ///   - xdm: XDM formatted event data passed as an XDMSchema
    ///   - data: Any free form data in a [String : Any] dictionary structure.
    public init(xdm: XDMSchema, data: [String: Any]? = nil) {...}
}

```
#### Swift

##### Examples

```swift
//Example 1
// set freeform data to the Experience event
var xdmData : [String: Any] = ["eventType" : "SampleXDMEvent",
                              "sample": "data"]

let experienceEvent = ExperienceEvent(xdm: xdmData, data: ["free": "form", "data": "example"])
```

```swift
//Example 2
// Create Experience Event from XDM Schema implementations
import AEPEdge

public struct XDMSchemaExample : XDMSchema {
    public let schemaVersion = "1.0" // Returns the version of this schema as defined in the Adobe Experience Platform.
    public let schemaIdentifier = "" // The URI identifier for this schema
    public let datasetIdentifier = "" // The identifier for the Dataset this event belongs to.

    public init() {}

    public var eventType: String?
    public var otherField: String?

    enum CodingKeys: String, CodingKey {
    case eventType = "eventType"
    case otherField = "otherField"
    }		
}

extension XDMSchemaExample {
    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      if let unwrapped = eventType { try container.encode(unwrapped, forKey: .eventType) }
      if let unwrapped = otherField { try container.encode(unwrapped, forKey: .otherField) }
    }
}

...

// Create Experience Event from XDMSchema
var xdmData = XDMSchemaExample()
xdmData.eventType = "SampleXDMEvent"
xdm.otherField = "OtherFieldValue"
let event = ExperienceEvent(xdm: xdmData)
```

```swift
//Example 3
// Set the destination Dataset identifier to the current Experience event:
var xdmData : [String: Any] = ["eventType" : "SampleXDMEvent",
                              "sample": "data"]

let experienceEvent = ExperienceEvent(xdm: xdmData, datasetIdentifier: "datasetIdExample")
```

#### Objective-C

##### Examples

```objectivec
//Example 1
// set freeform data to the Experience event
NSDictionary *xdmData = @{ @"eventType" : @"SampleXDMEvent"};
NSDictionary *data = @{ @"sample" : @"data"};

AEPExperienceEvent *event = [[AEPExperienceEvent alloc] initWithXdm:xdmData data:data datasetIdentifier:nil];
```
```objectivec
//Example 2
// Set the destination Dataset identifier to the current Experience event:
NSDictionary *xdmData = @{ @"eventType" : @"SampleXDMEvent"};

AEPExperienceEvent *event = [[AEPExperienceEvent alloc] initWithXdm:xdmData data:nil datasetIdentifier:@"datasetIdExample"];
```

------

See [Edge Extension Usage](../ExtensionUsage.md) for more examples.

------
