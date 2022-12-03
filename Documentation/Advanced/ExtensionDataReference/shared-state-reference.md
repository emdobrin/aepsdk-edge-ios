# Shared state reference

Shared state name: `com.adobe.edge`

The shared state for this extension is updated in the following scenarios:
- After the extension is initialized, it updates the shared state by reading the previously set value from persistence.
- The shared stare is updated with the latest value provided through the setLocationHint API.
- When the Edge Network provides a new location hint value than what was previously set.

| Key            | Type                      | Description |
| -------------- | ------------------------- | ----------- |
| locationHint   | String                    | The Edge Network location hint used in requests to the Adobe Experience Platform Edge Network |
