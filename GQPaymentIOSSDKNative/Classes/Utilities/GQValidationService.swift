//
//  GQValidationService.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 22/02/24.
//

import Foundation

//MARK: Validation services for Form  Validations.
final class GQValidationService {
    
    
//MARK: Mobile Number Validation.
    static func validate(mobileNumber: String?) -> Bool {
        let phoneRegex = #"^\d{10}$"#
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result = phoneTest.evaluate(with: mobileNumber)
        return result
    }
    
    static func onlyDigits(text: String?) -> Bool {
        let digitsRegex = #"^\d+$"#
        let digitsTest = NSPredicate(format: "SELF MATCHES %@", digitsRegex)
        let result = digitsTest.evaluate(with: text)
        return result
    }
    
    static func containsAnyValidEnvironment(_ value: String) -> Bool {
        let validEnvironments = ["test", "stage", "preprod", "live"]
        return validEnvironments.contains(value.lowercased())
    }
}
