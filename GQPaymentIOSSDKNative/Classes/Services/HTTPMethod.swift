//
//  HTTPMethod.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

enum HTTPMethod {
    case get
    case post
    
    public var string: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

struct GQRequestHeaders {
    static let noAuth = [
        "Content-Type" : "application/json"
    ]
    
    static let basicAuth = [
        "Content-Type" : "application/json",
        "GQ-API-Key"   : "\(GQEnvironment.shared.gqApiKey)",
        "Authorization": "Basic \(GQEnvironment.shared.abase ?? .empty)"
    ]
}
