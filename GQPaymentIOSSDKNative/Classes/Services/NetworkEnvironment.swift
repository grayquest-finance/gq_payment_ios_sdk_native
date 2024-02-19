//
//  NetworkEnvironment.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

enum NetworkEnvironment {
    case development
    case production
    case testing
    
}

extension NetworkEnvironment {
    public var baseURL: String {
        switch self {
        case .development:
            return "www.google.in"
        case .production:
            return "www.google.com"
        case .testing:
            return "www.google.to"
        }
    }
}
