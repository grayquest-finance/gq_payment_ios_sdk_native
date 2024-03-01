//
//  Decoder.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

class Decoder {
    
    static let shared = Decoder()
    
    func decode<T: Decodable>(data: Data, type: T.Type) throws -> T? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch (let error) {
            throw NetworkError.somethingWrong(error.localizedDescription)
        }
    }
    
}
