//
//  Pollution.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import Foundation
struct CityPollution: Codable {
    let coord: Coordinates
    let list: [Pollution]
}
