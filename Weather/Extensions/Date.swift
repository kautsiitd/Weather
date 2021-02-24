//
//  Date.swift
//  Weather
//
//  Created by Kautsya Kanu on 24/02/21.
//

import UIKit
extension Date {
    func string(in format: String, for timezone: Int? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        if let timezone = timezone {
            let hoursString: String
            let hours = timezone/3600
            if hours < -9 { hoursString = "-\(abs(hours))" }
            else if hours < 0 { hoursString = "-0\(abs(hours))" }
            else if hours < 10 { hoursString = "+0\(hours)" }
            else { hoursString = "+\(hours)" }
            let minutesString: String
            let minutes = (timezone%3600)/60
            if minutes < 10 { minutesString = "0\(minutes)" }
            else { minutesString = "\(minutes)" }
            let customTimezone = NSTimeZone(name: "UTC\(hoursString)\(minutesString)")! as TimeZone
            dateFormatter.timeZone = .some(customTimezone)
        } else {
            dateFormatter.timeZone = .current
        }
        dateFormatter.dateFormat = format
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
    }
    var symbol: UIImage {
        let hour = Calendar.current.component(.hour, from: self)
        switch hour {
        case 0..<6 : return UIImage(systemName: "sunrise.fill")!.withRenderingMode(.alwaysTemplate)
        case 6..<12 : return UIImage(systemName: "sun.max.fill")!.withRenderingMode(.alwaysTemplate)
        case 12..<18 : return UIImage(systemName: "sunset.fill")!.withRenderingMode(.alwaysTemplate)
        default: return UIImage(systemName: "moon.stars.fill")!.withRenderingMode(.alwaysTemplate)
        }
    }
    var symbolColor: UIColor {
        let hour = Calendar.current.component(.hour, from: self)
        switch hour {
        case 0..<12: return .systemYellow
        default: return .white
        }
    }
}
