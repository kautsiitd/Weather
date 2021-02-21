//
//  ApiError.swift
//  Weather
//
//  Created by Kautsya Kanu on 20/02/21.
//

enum ApiError: BaseError {
    case invalidURL, invalidData, custom(_ error: Error), unknown
    
    var title: String { return "Oops! 😬" }
    var message: String {
        let genericMessage = "Sorry, we couldn’t find that. Please try again."
        switch self {
        case .invalidURL: return "\(genericMessage)\n Invalid URL"
        case .invalidData: return "\(genericMessage)\n Invalid Data"
        case let .custom(error): return error.localizedDescription
        case .unknown: return genericMessage
        }
    }
}
