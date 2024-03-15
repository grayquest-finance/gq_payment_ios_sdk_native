//
//  Decoder.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

class GQEncoder {
    
    static let shared = GQEncoder()
    
    func encode(data: any Encodable) throws -> Data {
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            return try encoder.encode(data)
        } catch let error {
            throw GQError.somethingWrong(error.localizedDescription)
        }
    }
    
    func encode(dictionary: JSONDictionary) -> Data? {
        let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [.fragmentsAllowed])
        return data
    }
    
    func serialize(data: any Encodable) throws -> JSONDictionary? {
        do {
            let encoded = try Self.shared.encode(data: data)
            let serialized = try JSONSerialization.jsonObject(with: encoded)
            if let dictionary = serialized as? [String: Any] {
                return dictionary
            } else {
                throw GQError.somethingWrong("Could Not Serialize Data")
            }
        } catch (let error) {
            throw GQError.somethingWrong(error.localizedDescription)
        }
    }
    
}
