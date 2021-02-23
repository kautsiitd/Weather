//
//  Rain.swift
//  Weather
//
//  Created by Kautsya Kanu on 23/02/21.
//

import Foundation
struct Rain: Codable {
    ///Rain volume for last 3 hours, mm
    let threeHour: Float
}

extension Rain {
    enum CodingKeys: String, CodingKey {
        case threeHour = "3h"
    }
}
