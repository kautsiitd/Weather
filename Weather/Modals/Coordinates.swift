//
//  Coordinates.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import Foundation
import CoreLocation
///City geo location
struct Coordinates: Codable {
    ///longitude
    let lon: Double
    ///latitude
    let lat: Double
}

extension Coordinates {
    init(from location: CLLocation) {
        lon = location.coordinate.longitude
        lat = location.coordinate.latitude
    }
}
