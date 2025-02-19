# KFAssetCatalogImageProvider

A Swift package that extends Kingfisher to support loading images from Asset Catalogs using a custom URL scheme. 

# Why would you want this?

This is particularly useful for SwiftUI previews when you want to use local image assets from the 'Preview Content' image catalog.  You image locator remains a URL, and any sample data/builder can refer to those images via a URL, retaining KFImage semantics (placeholder, etc). 

## Requirements

- iOS 16.0+ / macOS 11.0+
- Swift 5.9+
- [Kingfisher](https://github.com/onevcat/Kingfisher) 8.0+

## Usage

The package implements a custom URL scheme `asset-catalog://` with a custom `KFImage` initializer.  

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

If you pass in a scheme of `file://` or `https://` that still works with the new initializer. 

### URL Format

- Basic usage: `asset-catalog://image_name.ext`
- With simulated delay: `asset-catalog://image_name.ext?delay=3` (3 seconds)

The delay parameter is particularly useful for testing loading states in SwiftUI previews.

## Features

- Load images from [Preview Content] Asset Catalog using Kingfisher
- Support for simulated network delays
- Retains Kingfisher's placeholder and error handling capabilities
- SwiftUI preview friendly

## License

This project is licensed under the MIT License - see the LICENSE file for details.
