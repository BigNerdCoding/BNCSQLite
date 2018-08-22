# BNCSQLite

A Objective-C Wrapper Around SQLite. Inspired by [CTPersistance](https://github.com/casatwy/CTPersistance).

## Installiing

BNCSQLite supports multiple methods for installing the library in a project

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like BNCSQLite in your projects. You can install it with the following command:

```
$ gem install cocoapods
```

#### Podfile

To integrate AFNetworking into your Xcode project using CocoaPods, specify it in your Podfile:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'BNCSQLite', '~> 1.0.0'
end
```

Then, run the following command:

```
$ pod install
```

### Installation with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

$ brew update
$ brew install carthage
To integrate BNCSQLite into your Xcode project using Carthage, specify it in your Cartfile:

github "BigNerdCoding/BNCSQLite" ~> 1.0.0
Run carthage to build the framework and drag the built BNCSQLite.framework into your Xcode project.

## License

BNCSQLite is released under the MIT license. See LICENSE for details.
