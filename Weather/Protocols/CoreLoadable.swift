//
//  CoreLoadable.swift
//  Weather
//
//  Created by Kautsya Kanu on 24/02/21.
//

import Foundation
protocol CoreLoadable: ApiRespondable {
    var fileName: String { get }
    var fileExtension: String { get }
    func loadData()
    func parse(_ data: Data) throws
}
