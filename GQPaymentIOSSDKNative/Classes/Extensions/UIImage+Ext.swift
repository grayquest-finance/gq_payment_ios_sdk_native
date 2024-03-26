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
        case otpIcon
        case newWindowIcon
        case supportIcon
        case rightArrow
        case incompleteCheckpointIcon
        case completeCheckpointIcon
        
        var name: String {
            return self.rawValue
        }
    }
    
    @nonobjc static func getImage(icon: GQImageIcons, renderingMode: RenderingMode = .automatic) -> UIImage? {
        return UIImage(named: icon.name,
                       in: GQPaymentSDK.bundle,
                       compatibleWith: .none
        )?.withRenderingMode(renderingMode)
    }
    
    
}
