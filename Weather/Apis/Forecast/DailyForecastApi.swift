//
//  DailyForecastApi.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import Foundation
class DailyForecastApi: BaseApiModal {
    //MARK:- Properties
    private var cityName: String = ""
    private var numberOfDays: Int = 7
    private var units: MeasurementUnit = .standard
    private var language: Language = .english
    var cityForecast: ForecastWeather?
    //MARK:- Fetchable
    override var apiEndPoint: String { "daily" }
    override var params: [String : AnyHashable] {
        ["q": cityName, "cnt": numberOfDays, "units": units, "lang": language.code]
    }
    override func parse(_ data: Data, for params: [String : AnyHashable]) throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        cityForecast = try decoder.decode(ForecastWeather.self, from: data)
    }
}
