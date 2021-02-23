//
//  ForecastWeather.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import Foundation
struct ForecastWeather: Codable {
    let city: City
    let cod: String
    let message: Double
    ///A number of days returned in the API response
    let cnt: Int
    let list: [WeatherDayDetail]
}

//MARK:- Temporary Structures
extension ForecastWeather {
    struct WeatherDayDetail: Codable {
        ///Time of data forecasted, unix, UTC
        let dt: Double
        let main: Main
        let weather: [Weather]
        ///Cloudiness **%**
        let clouds: Cloud
        let wind: Wind
        let visibility: Int
        ///Probability of precipitation
        let pop: Float
        let rain: Rain?
        let dtTxt: String
    }
}
