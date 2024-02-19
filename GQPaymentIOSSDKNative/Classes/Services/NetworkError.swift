//
//  NetworkError.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

enum NetworkError: Error {
    case noInterent
    case notFound
    case somethingWrong(String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInterent:
            return "No Internet Found"
        case .notFound:
            return "Not Found"
        case .somethingWrong(let description):
            return "Something Went Wrong: " + description
        }
    }
}
