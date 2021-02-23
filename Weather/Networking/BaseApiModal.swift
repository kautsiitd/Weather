//
//  BaseApiModal.swift
//  Weather
//
//  Created by Kautsya Kanu on 20/02/21.
//

import UIKit
class BaseApiModal: NSObject, Fetchable {
    weak var delegate: ApiRespondable?
    private var latestParams: [String: AnyHashable] = [:]
    
    //MARK:- Fetchable
    var id: String { "\(Self.self)" }
    var status: ApiStatus = .unknown
    var apiEndPoint: String { "" }
    var params: [String: AnyHashable] { [:] }
    
    func makeGetRequest() {
        status = .inProgress
        let updatedParams = update(params)
        latestParams = params
        do { try ApiManager.shared.getRequest(self) }
        catch let error { delegate?.didFail(with: ApiError.custom(error), for: updatedParams) }
    }
    
    func shouldParse(for params: [String : AnyHashable]) -> Bool {
        return params == latestParams
    }
    func parse(_ data: Data, for params: [String : AnyHashable]) throws {}
    func didFetchSuccessfully(for params: [String : AnyHashable]) {
        let updatedParams = update(params)
        delegate?.didFetchSuccessfully(for: updatedParams)
    }
    func didFail(with error: BaseError, for params: [String : AnyHashable]) {
        let updatedParams = update(params)
        delegate?.didFail(with: error, for: updatedParams)
    }
}

enum ApiStatus {
    case inProgress, success, error(with: BaseError), contentOver, unknown
}

//MARK:- Helpers
extension BaseApiModal {
    private func update(_ params: [String: AnyHashable]) -> [String: AnyHashable] {
        var updatedParams = params
        updatedParams["ApiType"] = id
        return updatedParams
    }
}
