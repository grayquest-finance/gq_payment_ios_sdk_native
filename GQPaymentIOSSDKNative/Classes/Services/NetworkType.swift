//
//  APIType.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

typealias JSONDictionary = [String: Any]

enum NetworkType {
    case createCustomer(JSONDictionary)
    
    static private var environment: GQNetworkEnvironment = .test
    
    static public func set(environment: GQNetworkEnvironment) {
        Self.environment = environment
    }
}

extension NetworkType {
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .createCustomer:
            return .post
        default:
            return .get
        }
    }
    
    public var endpoint: String {
        switch self {
        case .createCustomer:
            return NetworkType.environment.baseURL + "/v1" + "/customer/create-customer"
        }
    }
    
    public var parameters: JSONDictionary? {
        switch self {
        case .createCustomer(let params):
            return params
        }
    }
    
    public var headers: [String: String] {
        return ["Content-Type": "application/x-www-form-urlencoded",
                "Accept": "application/json",
                "GQ-API-Key": "\(Environment.shared.gqApiKey)",
                "Authorization": "Basic \(Environment.shared.abase ?? .empty)"
                ]
    }
    
    public var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
    
}
