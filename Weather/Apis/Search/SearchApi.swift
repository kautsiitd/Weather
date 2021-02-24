//
//  SearchApi.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import Foundation
import CoreData
final class SearchApi: CoreLoadable {
    //MARK:- Properties
    weak var delegate: ApiRespondable?
    var cities: [City]?
    //MARK:- CoreLoadable
    var fileName: String { "CityList" }
    var fileExtension: String { "json" }
    func loadData() {
        do { try ApiManager.shared.loadRequest(self) }
        catch let error { delegate?.didFail(with: FileError.custom(error), for: [:]) }
    }
    func parse(_ data: Data) throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        cities = try decoder.decode([City].self, from: data)
    }
    func didFetchSuccessfully(for params: [String : AnyHashable]) {
        delegate?.didFetchSuccessfully(for: params)
    }
    func didFail(with error: BaseError, for params: [String : AnyHashable]) {
        delegate?.didFail(with: error, for: params)
    }
}
