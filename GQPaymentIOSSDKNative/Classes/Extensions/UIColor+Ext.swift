//
//  UIColor+Ext.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 20/02/24.
//

import Foundation

extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
//  MARK: Red Shades
    @nonobjc static let red991F2C: UIColor = UIColor(red: 153, green: 31, blue: 44)
    
    
//  MARK: Green Shades
    @nonobjc static let green40850A: UIColor = UIColor(red: 64, green: 133, blue: 10)
    
    
//  MARK: Blue Shades
    @nonobjc static let blue4029CC: UIColor = UIColor(red: 64, green: 41, blue: 204)
    
    
//  MARK: Purple Shades
    @nonobjc static let purple63499D: UIColor = UIColor(red: 99, green: 73, blue: 157)
    

//  MARK: Gray Shades
    @nonobjc static let gray4D4B5A: UIColor = UIColor(red: 77, green: 75, blue: 90)
    @nonobjc static let gray807E8D: UIColor = UIColor(red: 128, green: 126, blue: 141)
    @nonobjc static let grayBFBFC6: UIColor = UIColor(red: 191, green: 191, blue: 198)
    @nonobjc static let grayD8D8D8: UIColor = UIColor(red: 216, green: 216, blue: 216)
    @nonobjc static let grayDFDFE3: UIColor = UIColor(red: 223, green: 223, blue: 227)
    
   
//  MARK: White Shades
    @nonobjc static let whiteF5F5F5: UIColor = UIColor(red: 245, green: 245, blue: 245)
    @nonobjc static let whiteFAFCFD: UIColor = UIColor(red: 250, green: 252, blue: 253)
    
    
//  MARK: Black Shades
    @nonobjc static let black4D4B5A: UIColor = UIColor(red: 77, green: 75, blue: 90)
    
}
