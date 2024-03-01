//
//  String+Ext.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 29/02/24.
//

import Foundation

extension String {
    
    internal static let empty = ""
    
    var isOnlyDigits: Bool {
        // Need to use regex.
        return self.allSatisfy{ $0.isNumber }
    }
    
}
