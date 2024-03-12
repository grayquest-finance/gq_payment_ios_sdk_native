//
//  APIType.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

typealias JSONDictionary = [String: Any]

enum GQNetworkType {
    case createCustomer(JSONDictionary)
    case customerSession(JSONDictionary)
    
    static private var environment: GQNetworkEnvironment = .test
    
    static let apiVersion: String = "/v1"
    
    static public func set(environment: GQNetworkEnvironment) {
        Self.environment = environment
    }
}

extension GQNetworkType {
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .createCustomer, .customerSession:
            return .post
        default:
            return .get
        }
    }
    
    public var endpoint: String {
        switch self {
        case .createCustomer:
            return GQNetworkType.environment.baseURL + GQNetworkType.apiVersion + "/customer/create-customer"
        case .customerSession:
            return GQNetworkType.environment.baseURL + GQNetworkType.apiVersion + "/wrapper/customer-session"
        }
    }
    
    public var parameters: JSONDictionary? {
        switch self {
        case .createCustomer(let params), .customerSession(let params):
            return params
        }
    }
    
    public var headers: [String: String] {
        return ["Content-Type" : "application/json",
                "Accept"       : "application/json",
                "GQ-API-Key"   : "\(GQEnvironment.shared.gqApiKey)",
                "Authorization": "Basic \(GQEnvironment.shared.abase ?? .empty)"
                ]
    }
    
    public var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
    
}
