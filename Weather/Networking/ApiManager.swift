//
//  ApiManager.swift
//  Weather
//
//  Created by Kautsya Kanu on 20/02/21.
//

import Foundation
class ApiManager {
    //MARK: Properties
    static let shared = ApiManager()
    private init() {}
    private let baseURL = URL(string: "https://api.openweathermap.org")!
    private let apiKey = "da96beb35a165f871ae1aff335f296b9"
    
    func getRequest(_ delegate: Fetchable) throws {
        let endPoint = delegate.apiEndPoint
        let params = delegate.params
        let updatedParams = update(params)
        guard let url = URL(endPoint, with: updatedParams, relativeTo: baseURL)
        else { throw ApiError.invalidURL }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error { delegate.didFail(with: ApiError.custom(error), for: params); return }
            guard let data = data else { delegate.didFail(with: ApiError.invalidData, for: params); return }
            
            //Main async required, so that View refresh itself before newData come
            DispatchQueue.main.async {
                if !delegate.shouldParse(for: params) { return }
                do { try delegate.parse(data, for: params)
                    delegate.didFetchSuccessfully(for: params) }
                catch let error {
                    let decoder = JSONDecoder()
                    if let serverSideError = try? decoder.decode(ServerSideError.self, from: data) {
                        delegate.didFail(with: ApiError.custom(serverSideError), for: params)
                    } else {
                        delegate.didFail(with: ApiError.custom(error), for: params)
                    }
                }
            }
        }.resume()
    }
    
    private func update(_ params: [String: AnyHashable]) -> [String: AnyHashable] {
        var newParams = params
        newParams["apiKey"] = apiKey
        return newParams
    }
}
