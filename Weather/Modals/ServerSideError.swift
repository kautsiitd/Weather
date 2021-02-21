//
//  ServerSideError.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import Foundation
struct ServerSideError: Codable, BaseError {
    let title: String
    let message: String
}

extension ServerSideError {
    enum CodingKeys: String, CodingKey {
        case title = "cod"
        case message
    }
}
