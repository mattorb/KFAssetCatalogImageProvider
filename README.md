# KFAssetCatalogImageProvider

A Swift package that extends Kingfisher to support loading images from Asset Catalogs using a custom URL scheme. This is particularly useful for SwiftUI previews where you want to maintain Kingfisher's image loading patterns while using local assets from the 'Preview Content' image catalog.

## Requirements

- iOS 16.0+ / macOS 11.0+
- Swift 5.9+
- [Kingfisher](https://github.com/onevcat/Kingfisher) 8.0+

## Usage

The package provides a custom URL scheme `asset-catalog://` that allows you to load images from your app's asset catalog using Kingfisher's `KFImage` view with a custom initializer:

```swift
import SwiftUI
import Kingfisher
import KFAssetCatalogImageProvider

struct ContentView: View {
    var body: some View {
        KFImage(smartURL: URL(string: "asset-catalog://image_name.jpg")!)
            .placeholder { _ in
                ProgressView()
            }
            .resizable()
            .scaledToFit()
    }
}
```

### URL Format

- Basic usage: `asset-catalog://image_name.ext`
- With simulated delay: `asset-catalog://image_name.ext?delay=3` (3 seconds)

The delay parameter is particularly useful for testing loading states in SwiftUI previews.

## Features

- Load images from Asset Catalog using Kingfisher
- Support for simulated network delays
- Retains Kingfisher's placeholder and error handling capabilities
- SwiftUI preview friendly

## License

This project is licensed under the MIT License - see the LICENSE file for details.
