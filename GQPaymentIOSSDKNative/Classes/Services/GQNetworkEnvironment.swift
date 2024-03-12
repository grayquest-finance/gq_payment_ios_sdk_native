//
//  NetworkEnvironment.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

enum GQNetworkEnvironment: String {
    case test
    case stage
    case preprod
    case live
}

extension GQNetworkEnvironment {
    
    var baseURL: String {
        switch self {
        case .stage:
            return "https://erp-api-stage.graydev.tech"
        case .preprod:
            return "https://erp-api-preprod.graydev.tech"
        case .live:
            return "https://erp-api.grayquest.com"
        default:
            return "https://erp-api.graydev.tech"
        }
    }
    
    static func isValid(environment: String) -> Bool {
        return GQNetworkEnvironment(rawValue: environment.lowercased()) != nil
    }
    
}
