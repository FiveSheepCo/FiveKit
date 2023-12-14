# FiveKit
> All of FiveSheep's in-house app development tooling in one package.

**FiveKit** is a collection of Swift packages developed by [FiveSheep](https://fivesheep.co) for our in-house app
development.

## How FiveKit Powers Our App Development

FiveKit is the backbone of all our app development at FiveSheep. It is a comprehensive toolkit that significantly
accelerates our development process, saving us countless hours on each app we build.

## Packages

### FoundationPlus

FoundationPlus is a key component of FiveKit. It is a collection of Swift extensions and utilities that supercharge our
Swift development. With FoundationPlus, we can quickly prototype and build robust applications. It eliminates the need
for repetitive code and allows us to focus on the unique aspects of each app, saving us many hours per app.

View the repository here: [FoundationPlus]

### SwiftUIElements

SwiftUIElements is another crucial part of FiveKit. It is a package of high-quality SwiftUI components, extensions, and
utilities. With SwiftUIElements, we can streamline our UI development process. It provides us with ready-to-use
components and extensions for SwiftUI, UIKit, and AppKit, reducing the time and effort required to build beautiful and
functional user interfaces.

View the repository here: [SwiftUIElements]

## FiveKit Meta-Package

While we provide all our packages individually, internally we use FiveKit to access our in-house packages. It's a single
import that empowers us to build better apps faster, and an indispensable tool in our app development arsenal.

## Installation

You can easily integrate **FiveKit** into your Swift project using Swift Package Manager. Here's how:

1. In Xcode, select "File" > "Swift Packages" > "Add Package Dependency..."
2. Enter the repository URL: `https://github.com/FiveSheepCo/FiveKit.git`
3. Follow the on-screen instructions to complete the installation.

## Usage

To start using **FiveKit**, simply import the package into your Swift files:

```swift
import FiveKit
```

Then, you can directly access the new features and enhancements provided by the package.

## Contributions

We welcome contributions to **FiveKit** and its individual packages. If you have any ideas, suggestions, bug reports, or
contributions, please open an issue or submit a pull request to the relevant repository. Please do not contribute to
FiveKit directly, since it's only a meta-package.

## License

**FiveKit** is available under the MIT license. See the [LICENSE](LICENSE.md) file for more info.

<!-- Links -->

[FoundationPlus]: https://github.com/FiveSheepCo/FoundationPlus
[SwiftUIElements]: https://github.com/FiveSheepCo/SwiftUIElements
