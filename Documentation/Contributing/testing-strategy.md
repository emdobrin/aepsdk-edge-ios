# Testing strategy

This document defines different levels of tests being used in this repository. To get started, please review the overview of the [Testing Strategy](https://github.com/adobe/aepsdk-core-ios/tree/main/Documentation/Testing) used in the Adobe Experience Platform Mobile SDKs. To review the existing tests for this repository, see the `Tests` folder.

### Unit testing

* CI runs unit tests after each code check-in.
* Unit testing should have the highest coverage between all types of testing.
* Should only test a single method.

### Functional testing

* CI runs functional tests after each code check-in.
* Black box tests for a single extension.
* Use the testable `ExtensionRuntime` to simulate or mock interactions with the Event Hub.
* Use the `MockNetworkService` to monitor or mock network activities.
* Test input: Simulated incoming events + shared states of other extensions + network responses
* Test output: Outgoing events + network requests + shared states

### Integration testing (client-side extension integrations)

* CI runs integration tests after each code check-in.
* Use the real `EventHub`, but `MockNetworkService`.
* Tests focus on:
    - Happy path of the public APIs for this Extension.
    - Dependencies between this Extension and other Extensions. In particular, shared state dependencies and event integrations.
* Integration tests for this repository can be found under the `Tests/FunctionalTests` folder.

### Integration testing (upstream integration)

* CI runs upstream integration tests when opening PRs to `staging` and `main` branches and also regularly on a cron scheduler.
* Use the real `EventHub`, but `RealNetworkService`.
* Tests focus on:
    - Happy path of the public APIs for this Extension.
    - Dependencies between this Extension and the server APIs. In particular, request/response contract, response and error handling.
* Upstream integration tests for this repository can be found under the `Tests/UpstreamIntegrationTests` folder.

### Manual testing

* Test with production-ready code against production servers.
* Test anything that cannot be covered by automated tests.
* Should be run before each release.
* Use the test application(s) under the `TestApps` folder.
