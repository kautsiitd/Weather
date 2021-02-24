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
}

//MARK:- Available Functions
extension ApiManager {
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
    
    func loadRequest(_ delegate: CoreLoadable) throws {
        guard let path = Bundle.main.path(forResource: delegate.fileName, ofType: delegate.fileExtension)
        else { throw FileError.notFound }
        let fileURL = URL(fileURLWithPath: path)
        DispatchQueue.global().async {
            do { let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                try delegate.parse(data)
                DispatchQueue.main.async {
                    delegate.didFetchSuccessfully(for: [:]) }
                }
            catch let error {
                DispatchQueue.main.async { delegate.didFail(with: FileError.custom(error), for: [:]) }
            }
        }
    }
}

//MARK:- Helpers
extension ApiManager {
    private func update(_ params: [String: AnyHashable]) -> [String: AnyHashable] {
        var newParams = params
        newParams["apiKey"] = apiKey
        return newParams
    }
}
