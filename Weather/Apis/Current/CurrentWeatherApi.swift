//
//  CurrentWeatherApi.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import Foundation
class CurrentWeatherApi: BaseApiModal {
    //MARK:- Properties
    private var query: String = ""
    private var units: MeasurementUnit = .standard
    private var language: Language = .english
    var cityWeather: CurrentWeather?
    //MARK:- Fetchable
    override var apiEndPoint: String { "weather" }
    override var params: [String : AnyHashable] {
        ["q": query, "units": units.rawValue, "lang": language.code]
    }
    override func parse(_ data: Data, for params: [String : AnyHashable]) throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        cityWeather = try decoder.decode(CurrentWeather.self, from: data)
    }
}
