//
//  Weather.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import Foundation
///More info Weather condition codes
struct Weather: Codable {
    ///Weather condition id
    let id: Int
    ///Group of weather parameters (Rain, Snow, Extreme etc.)
    let main: String
    ///Weather condition within the group. You can get the output in your language
    let description: String
    ///Weather icon id
    let icon: String
}
