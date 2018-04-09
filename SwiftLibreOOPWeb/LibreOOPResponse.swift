//
//  CreateRequestResponse.swift
//  SwitftOOPWeb
//
//  Created by Bjørn Inge Berg on 08.04.2018.
//  Copyright © 2018 Bjørn Inge Berg. All rights reserved.
//

import Foundation


struct LibreOOPResponse: Codable {
    let error: Bool
    let command: String
    let message: String?
    let result: Result?
    
    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case command = "Command"
        case message = "Message"
        case result = "Result"
    }
}

struct Result: Codable {
    let createdOn, modifiedOn, uuid, b64Contents: String
    let status: String
    let result: String?
    
    enum CodingKeys: String, CodingKey {
        case createdOn = "CreatedOn"
        case modifiedOn = "ModifiedOn"
        case uuid
        case b64Contents = "b64contents"
        case status, result
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

