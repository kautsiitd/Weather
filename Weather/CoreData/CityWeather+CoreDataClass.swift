//
//  CityWeather+CoreDataClass.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import Foundation
import CoreData

class CityWeather: NSManagedObject {
    //MARK: Properties
    @NSManaged var name: String
    @NSManaged var temp: Double
    
    @nonobjc class func fetchAllRequest() -> NSFetchRequest<CityWeather> {
        return NSFetchRequest<CityWeather>(entityName: "\(CityWeather.self)")
    }
    @nonobjc class func fetchRequest(for name: String) -> NSFetchRequest<CityWeather> {
        let request = NSFetchRequest<CityWeather>(entityName: "\(CityWeather.self)")
        let predicate = NSPredicate(format: "name == %@", name)
        request.predicate = predicate
        request.fetchLimit = 1
        return request
    }
}

