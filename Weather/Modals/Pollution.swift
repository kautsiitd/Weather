//
//  Pollution.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import Foundation
struct Pollution: Codable {
    let dt: Double
    let main: Main
    let components: PollutionComponent
}

struct PollutionComponent: Codable {
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm25: Double
    let pm10: Double
    let nh3: Double
}

//MARK:- Temporary Structures
extension Pollution {
    struct Main: Codable {
        let aqi: Int
        
        var aqiName: String {
            switch aqi {
            case 1: return "Good"
            case 2: return "Fair"
            case 3: return "Moderate"
            case 4: return "Poor"
            case 5: return "Very Poor"
            default: return "Unknown"
            }
        }
        var relativePos: Float {
            (2*aqi-1)/(2*5)
        }
    }
}
