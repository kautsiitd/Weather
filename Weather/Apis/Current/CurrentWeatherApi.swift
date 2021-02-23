//
//  CurrentWeatherApi.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import Foundation
final class CurrentWeatherApi: BaseApiModal {
    //MARK:- Properties
    var query: String?
    var location: Coordinates?
    private var units: MeasurementUnit = .metric
    private var language: Language = .english
    var cityWeather: CurrentWeather?
    //MARK:- Fetchable
    override var apiEndPoint: String { "data/2.5/weather" }
    override var params: [String : AnyHashable] {
        var dict: [String: AnyHashable] = ["units": units.rawValue, "lang": language.code]
        if let query = query { dict["q"] = query }
        else if let location = location {
            dict["lat"] = location.lat
            dict["lon"] = location.lon }
        else { dict["q"] = "Globe" }
        return dict
    }
    override func parse(_ data: Data, for params: [String : AnyHashable]) throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        cityWeather = try decoder.decode(CurrentWeather.self, from: data)
    }
}
