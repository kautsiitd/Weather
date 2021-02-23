//
//  Date.swift
//  Weather
//
//  Created by Kautsya Kanu on 24/02/21.
//

import UIKit
extension Date {
    func string(in format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = .current
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
