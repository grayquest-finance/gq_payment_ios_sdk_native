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
    static let red991F2C: UIColor = UIColor(red: 153, green: 31, blue: 44)
    
    
//  MARK: Green Shades
    static let green40850A: UIColor = UIColor(red: 64, green: 133, blue: 10)
    
    
//  MARK: Blue Shades
    static let blue4029CC: UIColor = UIColor(red: 64, green: 41, blue: 204)
    

//  MARK: Gray Shades
    static let gray4D4B5A: UIColor = UIColor(red: 77, green: 75, blue: 90)
    static let gray807E8D: UIColor = UIColor(red: 128, green: 126, blue: 141)
    static let grayBFBFC6: UIColor = UIColor(red: 191, green: 191, blue: 198)
    static let grayD8D8D8: UIColor = UIColor(red: 216, green: 216, blue: 216)

   
//  MARK: White Shades
    static let whiteF5F5F5: UIColor = UIColor(red: 245, green: 245, blue: 245)
    static let whiteFAFCFD: UIColor = UIColor(red: 250, green: 252, blue: 253)
    
}
