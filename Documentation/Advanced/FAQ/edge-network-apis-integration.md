# How should my Edge request look like

The Edge mobile extension handles multiple types of events that are delivered to the Adobe Edge Network through network calls.

In version 1.x and above, the extension integrates with /v1 of the interact and privacy APIs.

## Query parameters

| Query param name   | Description          |
| ------------------ | -------------------- |
| configId           | The datastream identifier set up in the configuration. |  
| requestId          | An external request tracing identifier, populated by default by the extension as a random UUID. |

## Data collection

When using the Edge.sendEvent API or sending an Experience event through the Event Hub, the Edge extension processes this event and initiates a request to `https://<edgedomain>/ee/v1/interact` endpoint.
This means the Edge mobile extension uses the interactive mode of the data collection endpoint, in which case the client expects back responses from the server that enable you for use-cases like personalization or other updates that the services need to bring down to the client.

#### Request example

https://example.data.adobedc.net/ee/v1/interact?configId=datastreamIdExample&requestId=286FF9DA-9BAE-4B33-80AA-56829583BF48

```
{
  "meta" : {
    "konductorConfig" : {
      "streaming" : {
        "enabled" : true,
        "recordSeparator" : "\u0000",
        "lineFeed" : "\n"
      }
    },
    "state" : {
      "entries" : [ ... ]
    }
  },
  "xdm" : {
    "identityMap" : {
      "ECID" : [
        {
          "id" : "29944430882988561504907120130798494851",
          "authenticatedState" : "ambiguous",
          "primary" : false
        }
      ]
    },
    "implementationDetails" : {
      "version" : "3.6.0+1.4.1",
      "name" : "https://ns.adobe.com/experience/mobilesdk/ios",
      "environment" : "app"
    }
  },
  "events" : [
    {
      "xdm" : {
        "_id" : "661DA72F-7BFD-491F-BEA6-AD324F5D88A6",
        "xdmfield" : "value",
        "timestamp" : "2022-07-12T18:50:35.948Z"
      },
      "data" : {
        "freeform" : "dataexample"
      }
    }
  ]
}
```

## Consent

When using the Consent.updateConsents API or sending a Consent event through the Event Hub, the Edge extension processes this event and initiates a request to the `https://<edgedomain>/ee/v1/privacy/set-consent` endpoint.

#### Request example

https://example.data.adobedc.net/ee/v1/privacy/set-consent?configId=datastreamIdExample&requestId=6EF44A98-5862-4877-9C1F-D13C86BE2CCF

```
{
  "meta" : {
    "konductorConfig" : {
      "streaming" : {
        "enabled" : true,
        "recordSeparator" : "\u0000",
        "lineFeed" : "\n"
      }
    }
  },
  "query" : {
    "consent" : {
      "operation" : "update"
    }
  },
  "identityMap" : {
    "ECID" : [
      {
        "id" : "29944430882988561504907120130798494851",
        "authenticatedState" : "ambiguous",
        "primary" : false
      }
    ]
  },
  "consent" : [
    {
      "standard" : "Adobe",
      "version" : "2.0",
      "value" : {
        "collect" : {
          "val" : "y"
        },
        "metadata" : {
          "time" : "2022-07-12T18:47:49Z"
        }
      }
    }
  ]
}
```

For more details, see also the [Edge Network Server API overview](https://experienceleague.adobe.com/docs/experience-platform/edge-network-server-api/overview.html).
