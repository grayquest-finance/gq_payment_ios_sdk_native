//
//  Decoder.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

class Encoder {
    
    static let shared = Encoder()
    
    func encode(data: any Encodable) throws -> Data {
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            return try encoder.encode(data)
        } catch let error {
            throw NetworkError.somethingWrong(error.localizedDescription)
        }
    }
    
    func serialize(data: any Encodable) throws -> [String: Any]? {
        do {
            let encoded = try Self.shared.encode(data: data)
            let serialized = try JSONSerialization.jsonObject(with: encoded)
            if let dictionary = serialized as? [String: Any] {
                return dictionary
            } else {
                throw NetworkError.somethingWrong("Could Not Serialize Data")
            }
        } catch (let error) {
            throw NetworkError.somethingWrong(error.localizedDescription)
        }
    }
    
}
