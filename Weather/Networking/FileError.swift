//
//  FileError.swift
//  Weather
//
//  Created by Kautsya Kanu on 24/02/21.
//

import Foundation
enum FileError: BaseError {
    case notFound, custom(_ error: Error)
    
    var title: String { return "Oops! 😬" }
    var message: String {
        switch self {
        case .notFound: return "File Not Found"
        case let .custom(error): return error.localizedDescription
        }
    }
}
