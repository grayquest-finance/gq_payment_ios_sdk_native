//
//  CreateCustomerResponse.swift
//  GQPaymentIOSSDKNative
//
//  Created by valentine on 06/03/24.
//

import Foundation

// MARK: - CreateCustomerResponse
struct CreateCustomerResponse: Codable {
    var success: Bool?
    var statusCode: Int?
    var message: String?
    var data: CreateCustomerData?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - DataClass
struct CreateCustomerData: Codable {
    var customerID: Int?
    var customerCode, customerMobile: String?

    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
        case customerCode = "customer_code"
        case customerMobile = "customer_mobile"
    }
}
