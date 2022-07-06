[![Swift 5.6](https://img.shields.io/badge/Swift-5.6-orange.svg?style=flat)](https://developer.apple.com/swift)
[![Platforms](https://img.shields.io/badge/Platforms-iOS_|_iPadOS_|_macOS_|_Mac_Catalyst_|_tvOS_|_watchOS-green?style=flat)](https://www.apple.com/ios/ios-15/)
[![CocoaPods Compatible](https://img.shields.io/badge/pod-v1.0.0-blue?style=flat)](https://cocoapods.org/)
[![Swift Package Index](https://img.shields.io/badge/Swift_Package_Index-compatible-blueviolet?style=flat)](https://swiftpackageindex.com/yonivav/CLLocationWrapper)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-brown?style=flat)](https://www.swift.org/package-manager/)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)

# CLLocation+Codable
A wrapper for CLLocation for encoding and decoding CLLocation

## Motivation

A lot of iOS applications work with the Core Location framework. The main object of Core Location is CLLocation, which represents a location. For some odd reason, Core Location doesn't conform to Codable protocol. Therefore, we can't serialize it by default, save it to a database, or send it through a network API.
This project solves it.

## Solution
In this [code](https://github.com/yonivav/CLLocationWrapper/tree/master/Sources/CLLocationWrapper), I created a wrapper for CLLocation which you can use to serialize and deserialize CLLocation.
Enjoy!

P.S. Check the [tests](https://github.com/yonivav/CLLocationWrapper/blob/master/Tests/CLLocationWrapperTests/CLLocationWrapperTests.swift) to see how it works and how to use CLLocationWrapper.

## Demo
Lets say you have a location:
```swift
import CoreLocation

let location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 16.6, longitude: 12.5),
                          altitude: 2.6,
                          horizontalAccuracy: 1.8,
                          verticalAccuracy: 9,
                          course: 46.891,
                          speed: 1.5,
                          timestamp: Date())
```

and you want to serialize it. You can wrap it:
```swift
let locationWrapper = CLLocationWrapper(location: location)
```
and voilà! it's serialized!

Now you can send it to server, save in User Defaults or write it to Data base:
```swift
let jsonEncoder = JSONEncoder()
do {
    let encodedLocationWrapper = try jsonEncoder.encode(locationWrapper.location)
    // Do what ever you want with the wrapped location
} catch {
    print("Error! Location wrapper encode failed: '\(error)'")
}
```

And how to decode it?

Very simple:
```swift
let jsonDecoder = JSONDecoder()
do {
    let decodedLocationWrapper = try jsonDecoder.decode(CLLocationWrapper.self, from: encodedLocationWrapper)
    // Do what ever you want with the wrapped location
} catch {
    print("Error! Location wrapper decode failed: '\(error)'")
}

```

## Installation

### CocoaPods
[CocoaPods](https://cocoapods.org) manages dependencies for your Xcode projects. For installation instructions and usage, visit their website. To integrate CLLocationWrapper into your Xcode project, specify it in your `Podfile`:

```ruby
pod 'CLLocationWrapper'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding CLLocationWrapper as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/yonivav/CLLocationWrapper.git")
]
```

### Manually

If you prefer not to use any of the mentioned dependency managers, you can integrate CLLocationWrapper into your project manually.
