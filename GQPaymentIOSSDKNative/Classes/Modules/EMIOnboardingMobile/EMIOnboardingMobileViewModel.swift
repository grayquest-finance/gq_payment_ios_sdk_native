//
//  EnterMobileNumberViewModel.swift
//  TestCases_Example
//
//  Created by valentine on 16/02/24.
//

import Foundation
import RegexBuilder

protocol EMIOnboardingMobileViewModelType: EMIOnboardingViewModelType {
    func beginSendOTPProcess() async throws
    func checkMobile() async throws
}

class EMIOnboardingMobileViewModel: EMIOnboardingViewModel, EMIOnboardingMobileViewModelType {
    

    
    func beginSendOTPProcess() async throws {
        try await authorize()
    }
    
    func checkMobile() async throws {
        
    }
    
}
