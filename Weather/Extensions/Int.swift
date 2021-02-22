//
//  Int.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import Foundation
extension Int {
    var direction: String {
        let degree = self % 360
        switch degree {
        case 0: return "N"
        case 1..<90: return "NE"
        case 90: return "E"
        case 90..<180: return "ES"
        case 180: return "S"
        case 180..<270: return "SW"
        case 270: return "W"
        case 270..<360: return "WN"
        default: return ""
        }
    }
}
