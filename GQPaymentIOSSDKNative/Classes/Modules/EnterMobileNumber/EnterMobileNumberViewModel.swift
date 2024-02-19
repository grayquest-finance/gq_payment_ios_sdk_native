//
//  EnterMobileNumberViewModel.swift
//  TestCases_Example
//
//  Created by valentine on 16/02/24.
//

import Foundation
import RegexBuilder

protocol EnterMobileNumberViewModelType {
    var gile: String? { get }
    
    func validate(mobileNumber: String?) -> Bool
}

class EnterMobileNumberViewModel: EnterMobileNumberViewModelType {
    
    var gile: String? = "Rarome ERP, Ahemdabad, NA"
    
    
    func validate(mobileNumber: String?) -> Bool {
        let phoneRegex = #"^\d{10}$"#
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result = phoneTest.evaluate(with: mobileNumber)
        return result
    }
    
}
