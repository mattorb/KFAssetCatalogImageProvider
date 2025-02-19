@preconcurrency import Kingfisher
import SwiftUI
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/// KingFisher ImageDataProvider that loads an asset from the asset catalog
/// Particularly useful for SwiftUI Previews, allowing you to load images from the 'Preview Content' asset catalog
public struct AssetImageDataProvider: ImageDataProvider {
    /// The name of the asset in the asset catalog
    public let assetName: String
    /// Optional delay to simulate network latency (in seconds)
    public let delay: TimeInterval
    
    public var cacheKey: String {
        return "asset-catalog://\(assetName)?delay=\(delay)"
    }
    
    public struct AssetLoadingError: Error {}
    
    /// Creates a new AssetImageDataProvider
    /// - Parameters:
    ///   - assetName: The name of the asset in the asset catalog
    ///   - delay: Optional delay to simulate network latency (in seconds)
    public init(assetName: String, delay: TimeInterval = 0) {
        self.assetName = assetName
        self.delay = delay
    }
    
    public func data(handler: @escaping @Sendable (Result<Data, Error>) -> Void) {
        Task {
            if delay > 0 {
                try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            }
            
            #if os(iOS)
            if let image = UIImage(named: assetName), let data = image.pngData() {
                handler(.success(data))
            } else {
                handler(.failure(AssetLoadingError()))
            }
            #elseif os(macOS)
            if let image = NSImage(named: assetName), let data = image.tiffRepresentation {
                handler(.success(data))
            } else {
                handler(.failure(AssetLoadingError()))
            }
            #endif
        }
    }
}

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
extension KFImage {
    @MainActor
    /// Creates a new KFImage that can load images from either a remote URL or the asset catalog
    /// - Parameter smartURL: The URL to load the image from. Can be:
    ///   - A regular http/https URL: behaves as normal Kingfisher URL loading
    ///   - An asset catalog URL: loads from local asset catalog
    ///     Format: `asset-catalog://image_name.ext` or `asset-catalog://image_name.ext?delay=3`
    ///     The delay parameter (in seconds) is useful for testing loading states in previews
    public init(smartURL: URL?) {
        if let url = smartURL,
           url.isAssetCatalogURL,
           let assetName = url.host(percentEncoded: false) {
            let provider = AssetImageDataProvider(assetName: assetName, delay: url.queryParameter(named: "delay", defaultValue: 0))
            self.init(source: .provider(provider))
        } else {
            self.init(smartURL)
        }
    }
}

private extension URL {
    var isAssetCatalogURL: Bool {
        return scheme == "asset-catalog"
    }
    
    func queryParameter(named: String, defaultValue: TimeInterval) -> TimeInterval {
        if let queryItems = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems {
            if let delayString = queryItems.first(where: { $0.name == "delay" })?.value,
               let delay = TimeInterval(delayString)
            {
                return delay
            }
        }
        
        return defaultValue
    }
}
