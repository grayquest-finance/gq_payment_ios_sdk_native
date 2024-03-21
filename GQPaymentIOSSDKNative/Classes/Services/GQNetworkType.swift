//
//  APIType.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

typealias JSONDictionary = [String: Any]

enum GQNetworkType {
    
    // ERP APIs
    case customerSession
    case authorize
    
    // Cust APIs
    case checkMobile
    
    // Noti APIs
    case sendOTP
    
    // SVC APIs
    
    
    static private var environment: GQNetworkEnvironment = .test
    
    static let apiVersion: String = "/v1"
    
    static public func set(environment: GQNetworkEnvironment) {
        Self.environment = environment
        GQLogger.shared.alert("Network Services on \(environment.rawValue)")
    }
}

extension GQNetworkType {
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .customerSession, .authorize:
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
        case .checkMobile:
            return GQNetworkType.environment.baseURL + GQNetworkType.apiVersion + "/auth/login/check-mobile"
        case .sendOTP:
            return GQNetworkType.environment.baseURL + GQNetworkType.apiVersion + "/customer-portal/otp/send-otp"
        }
    }
    
    public var headers: [String: String] {
        switch self {
        case .customerSession, .sendOTP:
            return GQRequestHeaders.basicAuth
        default:
            return GQRequestHeaders.noAuth
        }
    }
    
    public var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
    
}
