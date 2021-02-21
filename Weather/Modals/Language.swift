//
//  Language.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import Foundation
enum Language: String {
    case english
    case hindi
    
    var code: String {
        switch self {
        case .english: return "en"
        case .hindi: return "hi"
        }
    }
}
