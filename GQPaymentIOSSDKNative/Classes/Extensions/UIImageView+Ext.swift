//
//  UIImageView+Ext.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 13/03/24.
//

import UIKit

extension UIImageView {
    
    final func setImage(url: String?, placeHolder: UIImage? = nil) {
        if let cachedImage = ImageCache.shared.getCachedImage(for: url) {
            self.image = cachedImage
            return
        }
        
        self.image = placeHolder
        
        guard let urlString = url, let imageURL = URL(string: urlString) else { return }
        
        Task { [weak self] in
            let (imageData, _) = try await URLSession.shared.data(from: imageURL)
            let newImage = UIImage(data: imageData)
            self?.image = newImage
            ImageCache.shared.cacheNewImage(for: urlString, image: newImage)
        }
        
    }
    
}
