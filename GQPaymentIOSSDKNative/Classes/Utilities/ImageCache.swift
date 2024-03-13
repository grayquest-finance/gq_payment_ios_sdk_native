//
//  ImageCache.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 13/03/24.
//

import UIKit

final class ImageCache {
    lazy var cache = NSCache<AnyObject, UIImage>()
    
    static let shared = ImageCache()
    
    func getCachedImage(for url: String?) -> UIImage? {
        guard let cachedImage = self.cache.object(forKey: url as AnyObject) else { return nil }
        return cachedImage
    }
    
    func cacheNewImage(for url: String, image: UIImage?) {
        guard let image else { return }
        self.cache.setObject(image, forKey: url as AnyObject)
    }
    
}
