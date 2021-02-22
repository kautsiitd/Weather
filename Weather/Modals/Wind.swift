//
//  Wind.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import Foundation
struct Wind: Codable {
    ///Wind speed
    /// - **Unit Default**: meter/sec
    /// - **Metric**: meter/sec
    /// - **Imperial**: miles/hour.
    let speed: Double
    ///Wind direction, degrees (meteorological)
    let deg: Int
    ///Wind gust
    /// - **Unit Default**: meter/sec
    /// - **Metric**: meter/sec
    /// - **Imperial**: miles/hour.
    let gust: Int?
    
    //MARK:- Calculated Properties
    private(set) lazy var readableFormat: String = {
        return "\(deg.direction) \(speed) m/s"
    }()
}
