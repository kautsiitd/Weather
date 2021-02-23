//
//  PollutionApi.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import Foundation
class PollutionApi: BaseApiModal {
    //MARK:- Properties
    var location: Coordinates?
    private var units: MeasurementUnit = .metric
    private var language: Language = .english
    var cityPollution: CityPollution?
    //MARK:- Fetchable
    override var apiEndPoint: String { "data/2.5/weather" }
    override var params: [String : AnyHashable] {
        ["lat": location?.lat, "lon": location?.lon,
         "units": units.rawValue, "lang": language.code]
    }
    override func parse(_ data: Data, for params: [String : AnyHashable]) throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        cityPollution = try decoder.decode(CityPollution.self, from: data)
    }
}
