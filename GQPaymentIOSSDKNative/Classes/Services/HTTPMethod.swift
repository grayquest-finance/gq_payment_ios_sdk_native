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
