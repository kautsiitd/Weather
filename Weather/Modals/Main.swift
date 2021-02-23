//
//  Main.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import UIKit
struct Main: Codable {
    let temp: Double
    let feelsLike: CGFloat
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    let seaLevel: Int?
    let grndLevel: Int?
}
