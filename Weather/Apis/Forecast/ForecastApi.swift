//
//  ForecastApi.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import Foundation
class ForecastApi: BaseApiModal {
    //MARK:- Properties
    var query: String?
    var location: Coordinates?
    private var numberOfTimeStamps: Int = 8
    private var units: MeasurementUnit = .standard
    private var language: Language = .english
    var forecast: ForecastWeather?
    //MARK:- Fetchable
    override var apiEndPoint: String { "data/2.5/forecast" }
    override var params: [String : AnyHashable] {
        ["q": query, "cnt": numberOfTimeStamps, "units": units, "lang": language.code]
    }
    override func parse(_ data: Data, for params: [String : AnyHashable]) throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        forecast = try decoder.decode(ForecastWeather.self, from: data)
    }
}
