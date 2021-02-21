//
//  City.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import Foundation
struct City: Codable {
    ///City ID
    let id: Int
    ///City name
    let name: String
    let coord: Coordinates
    ///Country code (GB, JP etc.)
    let country: String
    let population: Int
    ///Shift in seconds from UTC
    let timezone: Double
}
