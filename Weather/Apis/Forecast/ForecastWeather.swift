//
//  ForecastWeather.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import Foundation
struct ForecastWeather: Codable {
    let city: City
    let cod: Int
    let message: Double
    ///A number of days returned in the API response
    let cnt: Int
    let list: [WeatherDayDetail]
}

extension ForecastWeather {
    struct WeatherDayDetail: Codable {
        ///Time of data forecasted
        let dt: Int
        let sunrise: Int
        let sunset: Int
        let temp: Temperature
        let feelsLike: Temperature
        ///Atmospheric pressure on the sea level, **hPa**
        let pressure: Double
        ///Humidity **%**
        let humidity: Int
        let weather: [Weather]
        ///Wind speed
        /// - **Unit Default**: meter/sec
        /// - **Metric**: meter/sec
        /// - **Imperial**: miles/hour.
        let speed: Float
        ///Wind direction, degrees (meteorological)
        let deg: Double
        ///Cloudiness **%**
        let clouds: Int
        ///Probability of precipitation
        let pop: Float
    }
}
