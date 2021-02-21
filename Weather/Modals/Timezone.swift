//
//  Timezone.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import Foundation

/// Timezone of a city
struct Timezone: Codable {
    ///Shift in seconds from UTC
    let timezone: Int
    ///City id
    let id: Int
    ///City name
    let name: String
    ///Internal Parameter
    let cod: Int
}
