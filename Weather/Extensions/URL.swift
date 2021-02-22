//
//  URL.swift
//  Weather
//
//  Created by Kautsya Kanu on 20/02/21.
//

import Foundation
extension URL {
    public init?(_ endPoint: String, with params: [String: Any], relativeTo baseURL: URL) {
        let paramsString = params.map { key, value in
            return "\(key)=\(value)"
        }.joined(separator: "&")
        
        let urlString = "\(endPoint)?\(paramsString)"
        self.init(string: urlString, relativeTo: baseURL)
    }
}

