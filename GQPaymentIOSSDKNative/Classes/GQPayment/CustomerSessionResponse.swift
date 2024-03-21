//
//  CustomerSessionResponse.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 12/03/24.
//

import Foundation

// MARK: - CustomerSessionResponse
struct CustomerSessionResponse: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: CustomerSessionResponseData?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - CustomerSessionData
struct CustomerSessionResponseData: Codable {
    var customerID: Int?
    var customerCode, customerMobile, sdkSessionCode, userType: String?

    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
        case customerCode = "customer_code"
        case customerMobile = "customer_mobile"
        case sdkSessionCode = "sdk_session_code"
        case userType = "user_type"
    }
}
