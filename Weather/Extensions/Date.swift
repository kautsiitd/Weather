//
//  Date.swift
//  Weather
//
//  Created by Kautsya Kanu on 24/02/21.
//

import Foundation
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
}
