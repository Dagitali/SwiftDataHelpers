# SwiftDataHelpers

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/Dagitali/SwiftDataHelpers?sort=semver)
![Build Status](https://github.com/Dagitali/SwiftDataHelpers/actions/workflows/lint.yml/badge.svg)
![Build Status](https://github.com/Dagitali/SwiftDataHelpers/actions/workflows/test.yml/badge.svg)
![Build Status](https://github.com/Dagitali/SwiftDataHelpers/actions/workflows/release.yml/badge.svg)
![Build Status](https://github.com/Dagitali/SwiftDataHelpers/actions/workflows/document.yml/badge.svg)
![Build Status](https://github.com/Dagitali/SwiftDataHelpers/actions/workflows/publish.yml/badge.svg)
![Codecov](https://codecov.io/gh/Dagitali/SwiftDataHelpers/branch/main/graph/badge.svg)
![GitHub](https://img.shields.io/github/license/Dagitali/SwiftDataHelpers)
![GitHub issues](https://img.shields.io/github/issues/Dagitali/SwiftDataHelpers)
![GitHub pull requests](https://img.shields.io/github/issues-pr/Dagitali/SwiftDataHelpers)
![GitHub top language](https://img.shields.io/github/languages/top/Dagitali/SwiftDataHelpers)
![GitHub repo size](https://img.shields.io/github/repo-size/Dagitali/SwiftDataHelpers)
![GitHub contributors](https://img.shields.io/github/contributors/Dagitali/SwiftDataHelpers)

A Swift package that includes an integrated collection of SwiftData extensions and related custom
abstractions.

- [SwiftDataHelpers](#swiftdatahelpers)
  - [Overview](#overview)
  - [Features](#features)
    - [Extensions](#extensions)
  - [Installation](#installation)
    - [Using Swift Package Manager (SPM)](#using-swift-package-manager-spm)
  - [Testing](#testing)
  - [Documentation](#documentation)
    - [Community Health](#community-health)
    - [Project](#project)
  - [Contributing](#contributing)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)

## Overview

SwiftDataHelpers is a Swift package designed to complement SwiftData, Apple’s native framework for
building Swift apps and packages.  It simplifies everyday coding tasks by extending key SwiftData
types, such as `ModelContainer`.

This package focuses on providing practical, reusable extensions and abstractions that:

- Simplify common patterns in SwiftData.
- Extend SwiftData’s capabilities without overriding or replacing its native functionality.

By integrating SwiftDataHelpers into your project, you can reduce boilerplate code, improve
readability, and adopt reusable patterns tailored for modern Swift apps and packages.

## Features

### Extensions

Enhance native SwiftData types with new properties and methods:

- `ModelContext`
- `PersistentModel`

🛠 **Custom Protocols**

Formalize common patterns by conforming data-related types (e.g., models) to new protocols:

- `TimestampedModel`

## Installation

### Using Swift Package Manager (SPM)

To integrate SwiftDataHelpers into your project:

1. Open your project in **Xcode**.
2. Navigate to **File > Add Packages**.
3. Enter the URL for this repository:

   <https://github.com/Dagitali/SwiftDataHelpers>

4. Select the latest version and add it to your target.

## Testing

The package includes a comprehensive test suite to ensure reliability.  Run tests with:

```bash
swift test
```

## Documentation

For detailed API documentation and more usage examples, visit the [SwiftDataHelpers][docs]
documentation section.  For project documentation, refer to the files listed in the subsections that
follow.

### Community Health

- [Code of Conduct](CODE_OF_CONDUCT.md)
- [Contributing](CONTRIBUTING.md)

### Project

- [References](REFERENCES.md)

## Contributing

Contributions are welcome!  If you’d like to add a new feature, fix a bug, or improve the
documentation:

1. Fork this repository.
2. Create a new feature branch for your changes (`git checkout -b feature/feature-name`).
3. Commit your changes (`git commit -m "Add feature"`).
4. Push to your branch (`git push origin feature-name`).
5. Submit a pull request with a detailed description.

## License

SwiftDataHelpers is available under the [MIT License](LICENSE).

## Acknowledgments

SwiftDataHelpers is inspired by common patterns in Swift development, aiming to reduce boilerplate
code and increase productivity.  Feedback and contributions are always appreciated!

Special thanks to the SwiftData community for fostering creativity and collaboration.

[docs]: https://dagitali.github.io/SwiftDataHelpers/documentation/swiftdatahelpers/
