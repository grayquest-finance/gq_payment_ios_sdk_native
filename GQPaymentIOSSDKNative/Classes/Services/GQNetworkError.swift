//
//  NetworkError.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

enum GQError: Error {
    case noInterent
    case notFound
    case invalidResponse
    case somethingWrong(String?)
}

extension GQError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInterent:
            return "No Internet Found"
        case .notFound:
            return "Not Found"
        case .invalidResponse:
            return "Inavlid Response"
        case .somethingWrong(let description):
            return description ?? GQStaticText.somethingWrong
        }
    }
}
