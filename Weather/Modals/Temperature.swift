//
//  Temperature.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import Foundation
struct Temperature: Codable {
    let day: Float
    let min: Float?
    let max: Float?
    let night: Float
    let eve: Float
    let morn: Float
}
