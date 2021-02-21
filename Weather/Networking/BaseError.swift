//
//  BaseError.swift
//  Weather
//
//  Created by Kautsya Kanu on 20/02/21.
//

protocol BaseError: Error {
    var title: String { get }
    var message: String { get }
}
