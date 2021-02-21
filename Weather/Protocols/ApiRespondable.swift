//
//  ApiRespondable.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import Foundation
protocol ApiRespondable: class {
    func didFetchSuccessfully(for params: [String: AnyHashable])
    func didFail(with error: BaseError, for params: [String: AnyHashable])
}
