# Extension integrations

As part of this document, discover the mobile extensions that integrate with the Adobe Experience Platform Edge Network extension.

## Identity for Edge Network (required)

The Edge extension automatically retrieves the most up to date identity information from the Identity for Edge Network extension in XDM IdentityMap format and attaches it to the Experience events sent to the Edge Network.
At a minimum the XDM IdentityMap contains the Experience Cloud Identifier (ECID) associated with current device. When other identities are updated with the Identity for Edge Network extension using the Identity.update API, they are also included in the Experience event until further updates/changes.

## Consent for Edge Network

The Edge extension automatically retrieves the most up to date consent preferences updated via the Consent for Edge Network extension and enforces the collect consent status for the events sent through this extension as follows:

| Collect yes (y) | Collect no (n)                | Collect pending (p)       |
| --------------- | ----------------------------- | ------------------------- |
| Hits are sent   | Hits are dropped and not sent | Hits are queued until y/n |

> **Note**
> When the Consent extension is not registered and no default collect consent value is defined, the SDK defaults to Yes (y) for collect consent.

For more details, see [Consent for Edge Network](https://aep-sdks.gitbook.io/docs/foundation-extensions/consent-for-edge-network) and [Privacy and GDPR](https://aep-sdks.gitbook.io/docs/resources/privacy-and-gdpr).

## Lifecycle for Edge Network

The Lifecycle extension enables application lifecycle data collection from your mobile app, in XDM format, following the [AEP Mobile Lifecycle Details](https://github.com/adobe/xdm/blob/master/docs/reference/adobe/experience/aep-mobile-lifecycle-details.schema.md) field group definition.

> **Note**
> The lifecycle data collection needs to be explicitly enabled in your Data Collection tag (mobile property) and requires the MobileCore.lifecycleStart and MobileCore.lifecyclePause APIs to be implemented. This feature requires AEPCore and AEPLifecycle v3.5.0 and above.
> - [Enable Lifecycle events forwarding in Data Collection UI](https://aep-sdks.gitbook.io/docs/foundation-extensions/lifecycle-for-edge-network)
> - [Register Lifecycle and add appropriate start/pause calls](https://aep-sdks.gitbook.io/docs/foundation-extensions/mobile-core/lifecycle).
