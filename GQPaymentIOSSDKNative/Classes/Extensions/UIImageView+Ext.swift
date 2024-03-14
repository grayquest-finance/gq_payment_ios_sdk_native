//
//  UIImageView+Ext.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 13/03/24.
//

import UIKit

extension UIImageView {
    
    internal func setOnMainThread(with image: UIImage?) {
        Task { @MainActor in
            self.image = image
        }
    }
    
    final func setImage(url: String?, placeHolder: UIImage? = nil) {
        if let cachedImage = ImageCache.shared.getCachedImage(for: url) {
            setOnMainThread(with: cachedImage)
            return
        }
        
        setOnMainThread(with: placeHolder)
        
        Task { [weak self] in
            let newImage: UIImage? = try? await ImageCache.shared.fetchImage(url: url)
            self?.setOnMainThread(with: newImage)
        }
        
    }
    
}
