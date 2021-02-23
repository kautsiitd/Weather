//
//  Notifications.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import Foundation
enum Notifications {
    case libraryUpdated
    
    var name: NSNotification.Name {
        switch self {
        case .libraryUpdated: return .init(rawValue: "com.weather.libraryUpdated")
        }
    }
}
