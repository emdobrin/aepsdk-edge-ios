# Configuration keys reference

| Key           | Value type     | Required | Description              |
| ------------- | -------------- | -------- | ------------------------ |
| edge.configId | String         | Yes      | The datastream identifier |
| edge.domain   | String         | Yes      | The domain used for requests to Edge Network and usually follows the format `<company>.data.adobedc.net`, where `<company>` is the unique namespace associated to your Adobe organization. The domain value should not contain the protocol or slashes. For example company.data.adobedc.net is a valid domain, where as https://company.data.adobedc.net/ is not. If not specified, the default `edge.adobedc.net` domain is used. |
| edge.environment | String | No | Edge environment used for testing purposes, for early integrations with new features or bug fix verifications prior to production. Supported values are `prod`, `pre-prod`, `int`. If not specified, the default environment `prod` is used. |
