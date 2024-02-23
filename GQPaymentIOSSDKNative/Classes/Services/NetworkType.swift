//
//  APIType.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

enum NetworkType {
    case home(any Encodable)
    case more(any Encodable)
    case listing(any Encodable)
    case detail(any Encodable)
    
    static private var environment: NetworkEnvironment = .production
    
    static public func set(environment: NetworkEnvironment) {
        Self.environment = environment
    }
}

extension NetworkType {
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .home, .more, .listing:
            return .get
        case .detail:
            return .post
        }
    }
    
    public var endpoint: String {
        switch self {
        case .home:
            return NetworkType.environment.baseURL + "/home"
        case .more:
            return NetworkType.environment.baseURL + "/more"
        case .listing:
            return NetworkType.environment.baseURL + "/listing"
        case .detail:
            return NetworkType.environment.baseURL + "/detail"
        }
    }
    
    public var parameters: (any Encodable)? {
        switch self {
        case .home(let parameter), .more(let parameter), .listing(let parameter), .detail(let parameter):
            return parameter
        }
    }
    
    public var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    public var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
}
