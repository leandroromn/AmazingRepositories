<p align="center">
    <img src="repository-images/amazing-repositories-logo.png" width="600" max-width="90%" alt="AmazingRepositories" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.1-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-11.2.1-orange.svg" />
    <a href="https://cocoapods.org">
        <img src="https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
    </a>
     <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://twitter.com/leandroromn" target="_blank">
        <img src="https://img.shields.io/badge/twitter-@leandroromn-blue.svg?style=flat" alt="Twitter: @leandroromn" />
    </a>
</p>

Welcome to **AmazingRepositories**, a simple iOS application to list recency, starred and forked repositories using GitHub API.

## Light and Dark Mode
AmazingRepository supports light mode and dark mode natively with iOS 13.

<p align="center">
    <img src="repository-images/light-mode.png" width="300" max-width="40%" alt="App with light mode" />
    <img src="repository-images/dark-mode.png" width="300" max-width="40%" alt="App with dark mode" />
</p>

## Repository Filters
Choose between recency, number of forks or number of stars filters to display repositories.

<p align="center">
    <img src="https://media.giphy.com/media/XccxxE6tKXVAGRizjm/giphy.gif" width="300" max-width="40%" alt="Repository Filters" />
</p>

## Architecture and third-party libraries
This project was built using **Clean Swift** architecture, a **native and generic network layer** and manage third-party dependencies with **CocoaPods**:
- **PromiseKit**: An alternative to simplify asynchronous tasks for Swift and ObjC.
- **Kingfisher**: A library for downloading and caching images from external sources.
- **Nimble**: An alternative to improve test assertions.
- **Quick**: A library for behavior-driven development tests.
- **Nimble-Snapshots**: A Nimble matchers for iOSSnapshotTestCase.
- **KIF**: A functional testing framework for interface tests.

## Installation
To build and run this project, follow the commands below:
```
$ git clone https://github.com/leandroromn/AmazingRepositories.git
$ cd AmazingRepositories
$ pod install
```

## Unit, Snapshot and Functional Tests
This project has unit, snapshot and functional (interface) tests. You can run all tests with `CMD + U` in **Xcode** or use **Slather** to get the test coverage reports.

Also, you can run a configured lane from **Fastlane** to use **Slather** in this project:
```
$ fastlane tests
```

There's a command to run **Slather** without **Fastlane**, if you prefer:
```
$ slather coverage --html --show --scheme AmazingRepositories --workspace AmazingRepositories.xcworkspace AmazingRepositories.xcodeproj
```

[Click here](https://github.com/SlatherOrg/slather#installation) to read more and install **Slather** in your machine.

#### Known issues:
- **Slather**: [Fail test code coverage not found coverage directory. #418](https://github.com/SlatherOrg/slather/issues/418)<br/>
There's a problem with Fastlane and Slather together. When Slather is executed, the tool cannot find the test coverage directory and returns an error. If this happens to you, run the Slather's command without Fastlane.
