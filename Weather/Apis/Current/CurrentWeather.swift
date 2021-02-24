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
        [0: (key: "SUNRISE",        value: sys.sunrise.date?.string(in: "h:mm a", for: timezone) ?? "--"),
         1: (key: "SUNSET",         value: sys.sunset.date?.string(in: "h:mm a", for: timezone) ?? "--"),
         2: (key: "HUMIDITY",       value: "\(main.humidity)%"),
         3: (key: "WIND",           value: wind.readableFormat),
         4: (key: "FEELS LIKE",     value: "\(main.feelsLike.rounded().i)°"),
         5: (key: "PRESSURE",       value: "\(main.pressure) hPa"),
         6: (key: "VISIBILITY",     value: "\(visibility/1000.0) km"),
         7: (key: "LOCAL TIME",     value: dt.date?.string(in: "h:mm a", for: timezone) ?? "--")]
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
        NotificationCenter.default.post(name: Notifications.libraryUpdated.name, object: nil,
                                        userInfo: ["cityName": name, "status": "added"])
    }
    func delete(from context: NSManagedObjectContext) throws {
        let request = CityWeather.fetchRequest(for: name)
        guard let cities = try? context.fetch(request), let city = cities.first else { return }
        let cityName = city.name
        context.delete(city)
        try context.save()
        NotificationCenter.default.post(name: Notifications.libraryUpdated.name, object: nil,
                                        userInfo: ["cityName": cityName, "status": "deleted"])
    }
    func isPresent(in context: NSManagedObjectContext) -> Bool {
        let request = CityWeather.fetchRequest(for: name)
        guard let cities = try? context.fetch(request) else { return false }
        return !cities.isEmpty
    }
}

//MARK:- Temporary Structures
extension CurrentWeather {
    struct Sys: Codable {
        let type: Int?
        let id: Int?
        let country: String
        let sunrise: Double
        let sunset: Double
    }
}
