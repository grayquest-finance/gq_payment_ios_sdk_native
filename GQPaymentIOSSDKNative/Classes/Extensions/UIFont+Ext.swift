//
//  UIFont+Ext.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 21/02/24.
//

import UIKit

//MARK: Function to register custom fonts in the SDK.
extension UIFont {
    
    static func registerFont(fileName: String, bundle: Bundle) {
        
        guard let pathForResourceString = bundle.path(forResource: fileName, ofType: nil) else {
            print("UIFont+:  Failed to register font: \(fileName) - for resource not found.")
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
    
    @nonobjc static func loadFonts() {
        guard !GQFonts.isLoaded else { return }
        
        let fonts = GQFonts.allCases
        
        fonts.forEach { font in
            font.fileNames.forEach { fileName in
                registerFont(fileName: fileName, bundle: GQPayment.bundle)
            }
        }
        
        GQFonts.isLoaded = true
    }
}

//MARK: Function to manage custom fonts and use them within the SDK.
extension UIFont {
    
    enum GQFonts: CaseIterable {
        
        static var fileExtension: String = ".ttf"
        static var isLoaded: Bool = false
        
        case dmSans
        case poppins
        
        var name: String {
            switch self {
            case .dmSans:
                return "DMSans"
            case .poppins:
                return "Poppins"
            }
        }
        
        var fileNames: [String] {
            let fontWeights = GQFontWeights.allCases
            return fontWeights.compactMap{ self.name + "-" + $0.name + Self.fileExtension }
        }
        
        func getFontName(with weight: GQFontWeights) -> String {
            return self.name + "-" + weight.name
        }
    }
    
    enum GQFontWeights: String, CaseIterable {
        case regular
        case medium
        case bold
        
        var name: String {
            return self.rawValue.capitalized
        }
    }
    
    @nonobjc static func customFont(_ font: GQFonts, weight: GQFontWeights, size: CGFloat) -> UIFont? {
        return UIFont(name: font.getFontName(with: weight), size: size)
    }
    
}
