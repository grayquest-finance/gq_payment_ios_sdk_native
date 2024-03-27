//
//  EMIOnboardingViewModel.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 26/03/24.
//

import Foundation

protocol EMIOnboardingViewModelType {
    var gile: String? { get }
    
    func authorize() async throws
}

class EMIOnboardingViewModel: EMIOnboardingViewModelType {
    
    var gile: String? = "GITAM Institute of Management, Mumbai, CBSE"
    
    func authorize() async throws {
        // Might be need to be called when SDK initialised, not dependant for now [Need to confirm]
        let authorizeTokenRequest = AuthorizeTokenRequest(platformCode: GQEnvironment.shared.platformCode)
        
        let authorizeResponse = try await GQNetworkService.shared.perform(networkType: .authorize, data: authorizeTokenRequest, responseType: AuthorizeTokenResponse.self)
        GQEnvironment.shared.updateTokens(authorizeResponse: authorizeResponse)
    }
    
}
