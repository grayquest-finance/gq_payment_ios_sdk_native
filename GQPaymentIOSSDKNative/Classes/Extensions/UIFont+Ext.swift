//
//  UIFont+Ext.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 21/02/24.
//

import UIKit

extension UIFont {
    
    static func registerFont(fileName: String, bundle: Bundle) {
        
        guard let pathForResourceString = bundle.path(forResource: fileName, ofType: nil) else {
            print("UIFont+:  Failed to register font - path for resource not found.")
            return
        }
        
        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("UIFont+:  Failed to register font - font data could not be loaded.")
            return
        }
        
        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("UIFont+:  Failed to register font - data provider could not be loaded.")
            return
        }
        
        guard let font = CGFont(dataProvider) else {
            print("UIFont+:  Failed to register font - font could not be loaded.")
            return
        }
        
        var errorRef: Unmanaged<CFError>?
        if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
            print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }
    
    static func loadFonts() {
        let fonts = GQFonts.allCases
        fonts.forEach {
            registerFont(fileName: $0.fileName, bundle: GQPayment.bundle)
        }
    }
}

extension UIFont {
    
    enum GQFonts: CaseIterable {
//    MARK: DMSans Fonts
        case DMSansRegular
        case DMSansMedium
        case DMSansBold
        
        var name: String {
            switch self {
                case .DMSansRegular:
                    return "DMSans-Regular"
                case .DMSansMedium:
                    return "DMSans-Medium"
                case .DMSansBold:
                    return "DMSans-Bold"
            }
        }
        
        var fileName: String {
            return self.name + ".ttf"
        }
    }
    
    static func customFont(_ font: GQFonts, size: CGFloat) -> UIFont? {
        return UIFont(name: font.name, size: size)
    }
    
}
