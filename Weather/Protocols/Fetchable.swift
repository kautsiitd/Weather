//
//  Fetchable.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import Foundation
protocol Fetchable: ApiRespondable {
    var id: String { get }
    var status: ApiStatus { get }
    var apiEndPoint: String { get }
    var params: [String: AnyHashable] { get }
    func makeGetRequest()
    func shouldParse(for params: [String: AnyHashable]) -> Bool
    func parse(_ data: Data, for params: [String: AnyHashable]) throws
}
