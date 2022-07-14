# Release process

The following is a list of steps needed to release the Edge extension for iOS/tvOS platform. The checklist outlines all the steps required for the release. Many of the items are partially or fully automated.

Before beginning, become familiar with the current state of the CI automation to assist in the release process.

<coming soon>

## Quick steps
### Prepare and validate the staging build
1. Update code dependencies
If the extension updates require new functionality, a new API or event from AEPCore (or AEPServices), make sure you update the AEPCore dependency in the following files:
  - Package.swift -> dependencies
  - AEPEdge.podspec -> s.dependency

2. Update extension version number
> **Note**
> Now is a good time to double check the bump in version number conforms to [semantic versioning](https://semver.org/). If the release includes API changes, the minor number may need to change.

Edit the following project files in dev branch to update the extension version:
  - AEPEdge.podspec file -> s.version
  - Internal extension version under Sources/EdgeConstants.swift -> EXTENSION_VERSION
  - The version for the AEPEdge target. Open the workspace in Xcode -> select AEPEdge workspace -> select AEPEdge target -> select General and update the Version.

3. Merge all code changes scheduled for this release (merged into dev branch) to staging branch
4. Verify all tests pass on the staging branch. See also the [testing-strategy](./testing-strategy.md).
5. If issues are discovered during staging validation, evaluate the impact and include new fixes to staging branch

### Prepare and validate the public release
1. Merge code from staging to main branch
2. Run the release job. This is a manual GitHub Action workflow.
   - Navigate to Actions, then select the `Release` workflow
   - Select the `main` branch
   - Set the tag/version as the extension release version
   - Set create tag to `yes`
   - Set release to Cocoapods to `yes`
   - Select `Run workflow`
   - Wait for the workflow to run and check it was successful

3. Run a smoke test with the test app / sample app with the recently released version
4. Verify the new release tag and release notes, make adjustments if needed
5. Publish release notes to the main documentation repo

### Post-release steps
1. Merge commits from main back to dev branch. Alternatively, if the repo uses `dev-vx.y.z` branch name format, create a new dev branch from main incrementing the version `dev-vx.y.z+1` and remove the old one.
