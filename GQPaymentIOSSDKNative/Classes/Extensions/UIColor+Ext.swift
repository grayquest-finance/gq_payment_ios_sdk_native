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
    
//  MARK: Blue Shades
    static let blue4029CC: UIColor = UIColor(red: 64, green: 41, blue: 204)

//  MARK: Gray Shades
    static let gray807E8D: UIColor = UIColor(red: 128, green: 126, blue: 141)
    static let grayBFBFC6: UIColor = UIColor(red: 191, green: 191, blue: 198)


   
    
}
