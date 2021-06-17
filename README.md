# Currency

Currency is a Swift library to handle fiat currency conversions using up-to-date exchange rates provided by currencylayer.com.

## Requirements

iOS 11.0+

## Installation

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

Once you have your Swift package set up, adding Currency as a dependency is as easy as adding it to the dependencies value of your `Package.swift`.

dependencies: [
    .package(url: "https://gitpub.rakuten-it.com/scm/~aaron.lee/mag-sdk-ios-ojt.git", .upToNextMajor(from: "1.0.0"))
]

## Usage

```swift
import Currency

let api = Currency(apiKey: "my-currency-layer-access-key")
let amount = 420
let currencyToConvertFrom = "JPY"
api.convert(amount: amount, source: currencyToConvertFrom) { currencies in
	currencies.forEach {
		print($0.description)
	}
}
```
