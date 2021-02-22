//
//  CurrentWeather.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import UIKit
struct CurrentWeather: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Double
    var wind: Wind
    let clouds: Cloud
    ///Time of data calculation, unix, UTC
    let dt: Double
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    //MARK:- Calculated Properties
    private(set) lazy var summaryDict: [Int: KeyValueString] = {
        [0: (key: "SUNRISE",        value: sys.sunrise.localTime),
         1: (key: "SUNSET",         value: sys.sunset.localTime),
         2: (key: "HUMIDITY",       value: "\(main.humidity)%"),
         3: (key: "WIND",           value: wind.readableFormat),
         4: (key: "FEELS LIKE",     value: "\(main.feelsLike.rounded().i)°"),
         5: (key: "PRESSURE",       value: "\(main.pressure) hPa"),
         6: (key: "VISIBILITY",     value: "\(visibility/1000.0) km"),
         7: (key: "LAST UPDATED",   value: dt.localTime)]
    }()
}

//MARK:- Temporary Structures
extension CurrentWeather {
    struct Main: Codable {
        let temp: Double
        let feelsLike: CGFloat
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
        let sunrise: Double
        let sunset: Double
    }
}
