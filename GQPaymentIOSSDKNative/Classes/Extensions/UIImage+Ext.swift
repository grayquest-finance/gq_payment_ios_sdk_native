//
//  UIImage+Ext.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 22/02/24.
//

import UIKit

extension UIImage {
    
    enum GQImageIcons: String {
        case grayQuestIcon
        case closeIcon
        case backIcon
        case phoneIcon
        
        var name: String {
            return self.rawValue
        }
    }
    
    @nonobjc static func getImage(icon: GQImageIcons, renderingMode: RenderingMode = .automatic) -> UIImage? {
        return UIImage(resource: ImageResource(name: icon.name,
                                               bundle: GQPayment.bundle)
            ).withRenderingMode(renderingMode)
    }
    
    
}
