//
//  APIType.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

typealias JSONDictionary = [String: Any]

enum GQNetworkType {
    case customerSession(JSONDictionary)
    case authorize
    
    static private var environment: GQNetworkEnvironment = .test
    
    static let apiVersion: String = "/v1"
    
    static public func set(environment: GQNetworkEnvironment) {
        Self.environment = environment
    }
}

extension GQNetworkType {
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .customerSession:
            return .post
        default:
            return .get
        }
    }
    
    public var endpoint: String {
        switch self {
        case .customerSession:
            return GQNetworkType.environment.baseURL + GQNetworkType.apiVersion + "/wrapper/customer-session"
        case .authorize:
            return GQNetworkType.environment.baseURL + GQNetworkType.apiVersion + "/auth/authorize"
        }
    }
    
    public var parameters: JSONDictionary? {
        switch self {
        case .customerSession(let params):
            return params
        case .authorize:
            return nil
        }
    }
    
    public var headers: [String: String] {
        return ["Content-Type" : "application/json",
                "GQ-API-Key"   : "\(GQEnvironment.shared.gqApiKey)",
                "Authorization": "Basic \(GQEnvironment.shared.abase ?? .empty)"
                ]
    }
    
    public var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
    
}
