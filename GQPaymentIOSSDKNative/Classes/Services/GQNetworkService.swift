//
//  APIService.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

final class GQNetworkService {
    
    static let shared = GQNetworkService()
    
    private init() { }
    
    func perform<T: Decodable>(networkType: GQNetworkType, responseType: T.Type) async throws -> T? {
        
//    MARK: Request Parameters
        guard let url = URL(string: networkType.endpoint) else { throw GQError.notFound }
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
        
//    MARK: Response Parameters
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw GQError.invalidResponse }
            guard (200...299) ~= httpResponse.statusCode else {
                let errorModel = try Decoder.shared.decode(data: data, type: GQNetworkErrorResponse.self)
                throw GQError.somethingWrong(errorModel?.message)
            }
            
            let model = try Decoder.shared.decode(data: data, type: T.self)
            return model
        } catch is DecodingError {
            throw GQError.somethingWrong(GQStaticText.somethingWrong + " - Decoding Error")
        } catch (let error) {
            GQLogger.shared.error(error.localizedDescription)
            throw GQError.somethingWrong(error.localizedDescription)
        }
        
//        return nil
    }
    
    
}
