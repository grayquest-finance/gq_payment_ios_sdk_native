//
//  APIService.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() { }
    
    func perform<T: Decodable>(networkType: NetworkType, responseType: T.Type) async throws -> T? {
        
        guard let url = URL(string: networkType.endpoint) else { throw NetworkError.notFound }
        var request = URLRequest(url: url)
        
        request.cachePolicy = networkType.cachePolicy
        request.allHTTPHeaderFields = networkType.headers
        request.httpMethod = networkType.httpMethod.string
        
        if let parameters = networkType.parameters {
            switch networkType.httpMethod {
            case .get:
                var components = URLComponents(string: request.url?.absoluteString ?? .empty)
                var queryItems = components?.queryItems ?? []
                for (key, value) in parameters {
                    let query = URLQueryItem(name: key, value: "\(value)")
                    queryItems.append(query)
                }
                components?.queryItems = queryItems
                request.url = components?.url
            case .post:
                let encoded = GQEncoder.shared.encode(dictionary: parameters)
                request.httpBody = encoded
            }
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let model = try Decoder.shared.decode(data: data, type: T.self)
            return model
        } catch (let error) {
            throw NetworkError.somethingWrong(error.localizedDescription)
        }
        
//        return nil
    }
    
    
}
