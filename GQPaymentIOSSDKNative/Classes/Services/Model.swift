//
//  Model.swift
//  TestCases_Example
//
//  Created by valentine on 09/02/24.
//

import Foundation

struct Model: Encodable {
    var id: String?
    var name: String?
}

struct Response: Decodable {
    var data: String?
    var status: Int?
}
