//
//  String.swift
//  Weather
//
//  Created by Kautsya Kanu on 24/02/21.
//

import Foundation
extension String {
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.date(from: self)
    }
}
