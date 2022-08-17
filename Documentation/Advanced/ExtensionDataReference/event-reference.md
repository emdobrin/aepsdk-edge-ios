# Event reference

## Events handled by Edge

The following events are handled by the Edge extension client-side.

### Edge request content

This event is a request to process and deliver an Experience event to Edge Network. This event is created when the `Edge.sendEvent(ExperienceEvent)` API is called.

#### Event Details

| Event type                 | Event source                         |
| -------------------------- | ------------------------------------ |
| com.adobe.eventType.edge   | com.adobe.eventSource.requestContent |

#### Data payload definition

| Key       | Value type    | Required | Description           |
| --------- | ------------- | -------- | --------------------- |
| xdm       | [String: Any] | Yes      | XDM formatted data; use an `XDMSchema` implementation for a better XDM data ingestion and format control. |
| data      | [String: Any] | No       | Optional free-form data associated with this event. |
| datasetId | String        | No       | Dataset identifier, if not set the default AEP Experience dataset identifier set in the datastream is used |

### Edge update consent

This event is a request to process and deliver a Consent update event to Edge Network. For example, this event is created when the `Consent.update(with consents)` API is called.

#### Event Details

| Event type                 | Event source                         |
| -------------------------- | ------------------------------------ |
| com.adobe.eventType.edge   | com.adobe.eventSource.updateConsent  |

#### Data payload definition

| Key       | Value type    | Required | Description           |
| --------- | ------------- | -------- | --------------------- |
| consents  | [String: Any] | Yes      | XDM formatted consent preferences. |

### Edge consent response content

This event contains the latest consent preferences synced with the SDK, usually updated after the server response was received for a `Consent.update(with consents)` request.
The Edge extension reads the current collect consent settings and adjusts the internal queueing settings based on that as follows:

| Yes (y)        | No (n)            | Pending (p)     |
| -------------- | ----------------- | --------------- |
| Hits are sent  | Hits are not sent | Hits are queued until y/n |

#### Event Details

| Event type                        | Event source                          |
| --------------------------------- | ------------------------------------- |
| com.adobe.eventType.edgeConsent   | com.adobe.eventSource.responseContent |

#### Data payload definition

| Key       | Value type    | Required | Description           |
| --------- | ------------- | -------- | --------------------- |
| consents  | [String: Any] | No       | XDM formatted consent preferences containing current collect consent settings. If not specified, defaults to pending (p) until the value is updated. |

### Generic identity request reset

This event indicates the an identity reset request was initiated, usually through the `MobileCore.resetIdentities()` API. When this event is received, the Edge extension queues it up and removes the cached internal state:store settings. If other events are queued before this event, these events will be processed first in the order they were received.

#### Event Details

| Event type                            | Event source                         |
| ------------------------------------- | ------------------------------------ |
| com.adobe.eventType.genericIdentity   | com.adobe.eventSource.requestReset   |

#### Data payload definition

N/A

## Events dispatched by Edge

The following events are dispatched by the Edge extension client-side.
<todo>
