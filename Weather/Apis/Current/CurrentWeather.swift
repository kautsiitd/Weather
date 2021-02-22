//
//  CurrentWeather.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import Foundation
struct CurrentWeather: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    var wind: Wind
    let clouds: Cloud
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    //MARK:- Calculated Properties
    private(set) lazy var summaryDict: [Int: KeyValueString] = {
        [0: (key: "SUNRISE",    value: "\(sys.sunrise)"),
         1: (key: "SUNSET",     value: "\(sys.sunset)"),
         2: (key: "TEMP MIN",   value: "\(main.tempMin)°"),
         3: (key: "TEMP MAX",   value: "\(main.tempMax)°"),
         4: (key: "HUMIDITY",   value: "\(main.humidity)%"),
         5: (key: "WIND",       value: wind.readableFormat),
         6: (key: "FEELS LIKE", value: "\(main.feelsLike)°"),
         7: (key: "PRESSURE",   value: "\(main.pressure) hPa"),
         8: (key: "VISIBILITY", value: "\(visibility) m")]
    }()
}

//MARK:- Temporary Structures
extension CurrentWeather {
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
    }
    struct Cloud: Codable {
        let all: Int
        
    }
    struct Sys: Codable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }
}
