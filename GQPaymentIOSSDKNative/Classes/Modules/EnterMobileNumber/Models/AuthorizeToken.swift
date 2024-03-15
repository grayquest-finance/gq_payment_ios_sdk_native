//
//  AuthorizeTokenResponse.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 15/03/24.
//

// MARK: - AuthorizeTokenResponse
struct AuthorizeTokenRequest: Encodable {
    var platformCode: String?
    
    enum CodingKeys: String, CodingKey {
        case platformCode = "platform_code"
    }
}

// MARK: - AuthorizeTokenResponse
struct AuthorizeTokenResponse: Decodable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: AuthorizeTokenData?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - AuthorizeTokenData
struct AuthorizeTokenData: Decodable {
    var accessToken, refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
