//
//  GQUtility.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 05/03/24.
//

import Foundation

final class GQUtility {
    
    static func convertDictionaryToJson(dictionary: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
}
