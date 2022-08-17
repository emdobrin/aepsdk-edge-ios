# Events persistence and failover mechanism

The Edge extension uses a persistent hit queue in order to temporarily store the events until the network request successfully delivered them to the Adobe Edge Network.

## Use-cases for which a queueing mechanism is required

* On a mobile device it is common that the user may encounter network connectivity issues or low internet bandwidth, or the application operates in an offline scenario for a longer period of time.
* The extension accounts for unexpected errors, for example when the service is temporarily unavailable or in case the server returns 429 Too Many Requests HTTP response.

In these use-cases, the network request is retried after a cool down period.

## Persistent queueing details

* The events are persistently queued when a valid configuration shared state is available, containing a non-null/non-empty "edge.configid".
* The events are queued as small chunks of data in the same ordered they were received from the Event Hub.
* At queueing time, the events contain all the relevant information be then processed, meaning to be sent as a network request when the connectivity permits.
* All the events are persisted by default and there is no batchLimit setting. The events are processed as soon as possible.
* Once the event was sent successfully the event is removed from persistence, then the processing continues with the next available event.
* In case of an unrecoverable response error code, the event is removed and not retried, the processing continues with the next available event.

## Retry mechanism for non-successful events

If an event failed to be sent to the Adobe Edge Network because of one of the following server response codes, the network requests will be retried:
    - 408 Client Timeout
    - 429 Too Many Requests
    - 502 Bad Gateway
    - 503 Service Unavailable
    - 504 Gateway Timeout

In some cases, for example in case of a 429 or 503 Service Unavailable, the server may return a `Retry-After` response header. The client uses this value as a cool down timeout until the next retry is executed.

## Is events batching supported?
Batching is currently not supported in the Edge extension. The hits are queued and processed individual network requests.
