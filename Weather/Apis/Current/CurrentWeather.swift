//
//  CurrentWeather.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import UIKit
import CoreData
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
         7: (key: "LOCAL TIME",     value: dt.localTime)]
    }()
}

//MARK:- Available Functions
extension CurrentWeather {
    func save(to context: NSManagedObjectContext) throws {
        if isPresent(in: context) { return }
        let cityWeather = CityWeather(context: context)
        cityWeather.name = name
        cityWeather.temp = main.temp
        try context.save()
    }
    func delete(from context: NSManagedObjectContext) throws {
        NSLog("Delete is not Supported yet!!")
    }
    func isPresent(in context: NSManagedObjectContext) -> Bool {
        let request = CityWeather.fetchAllRequest()
        let predicate = NSPredicate(format: "name == %@", name)
        request.predicate = predicate
        guard let todos = try? context.fetch(request) else { return false }
        return !todos.isEmpty
    }
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
