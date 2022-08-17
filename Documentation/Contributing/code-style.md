# Code style

This project uses [SwiftLint](https://github.com/realm/SwiftLint) to check and enforce the Swift style and conventions. Style checks are automatically applied when the project is built from Xcode.

To install the necessary tools and enable the Git pre-commit hook to autocorrect the style on each commit, run the following to update the project's git config `core.hooksPath`:

```
make setup-tools
```

To check current lint status run the following command:

```
make lint
```

To autocorrect the code on demand run the following command:

```
make lint-autocorrect
```

To check out the current rules applied to this project, refer to the `.swiftlint.yml` file. Different rules may be applied for the test classes, so you can find them under the `/Tests/TestUtils/.swiftlint.yml` config file.
