//
//  Double.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import Foundation
extension Double {
    var date: Date? {
        return Date(timeIntervalSince1970: self)
    }
}
