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
    
    func authorize() async throws
}

class EnterMobileNumberViewModel: EnterMobileNumberViewModelType {
    
    var gile: String? = "GITAM Institute of Management, Mumbai, CBSE"
    
    func beginSendOTPProcess() async throws {
        try await authorize()
    }
    
    func authorize() async throws {
        // Might be need to be called when SDK initialised, not dependant for now [Need to confirm]
        let authorizeTokenRequest = AuthorizeTokenRequest(platformCode: GQEnvironment.shared.platformCode)
        
        let authorizeResponse = try await GQNetworkService.shared.perform(networkType: .authorize, data: authorizeTokenRequest, responseType: AuthorizeTokenResponse.self)
        GQEnvironment.shared.updateTokens(authorizeResponse: authorizeResponse)
    }
    
    func checkMobile() async throws {
        
    }

    
}
