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
        return GQValidationService.onlyDigits(text: self)
    }
    
    func encodeStringToBase64() -> String? {
        if let inputData = self.data(using: .utf8) {
            return inputData.base64EncodedString()
        }
        return nil
    }
    
}
