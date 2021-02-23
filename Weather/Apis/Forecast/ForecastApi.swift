//
//  ForecastApi.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import Foundation
final class ForecastApi: BaseApiModal {
    //MARK:- Properties
    var query: String?
    var location: Coordinates?
    private var numberOfTimeStamps: Int = 8
    private var units: MeasurementUnit = .metric
    private var language: Language = .english
    var forecast: ForecastWeather?
    //MARK:- Fetchable
    override var apiEndPoint: String { "data/2.5/forecast" }
    override var params: [String : AnyHashable] {
        var dict: [String: AnyHashable] = ["cnt": numberOfTimeStamps,
                                           "units": units.rawValue, "lang": language.code]
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
        forecast = try decoder.decode(ForecastWeather.self, from: data)
    }
}
