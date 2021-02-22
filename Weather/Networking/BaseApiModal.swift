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
    var status: ApiStatus = .unknown
    var apiEndPoint: String { "" }
    var params: [String: AnyHashable] { [:] }
    
    func makeGetRequest() {
        status = .inProgress
        latestParams = params
        do { try ApiManager.shared.getRequest(self) }
        catch let error { delegate?.didFail(with: ApiError.custom(error), for: params) }
    }
    
    func shouldParse(for params: [String : AnyHashable]) -> Bool {
        return params == latestParams
    }
    func parse(_ data: Data, for params: [String : AnyHashable]) throws {}
    func didFetchSuccessfully(for params: [String : AnyHashable]) {
        delegate?.didFetchSuccessfully(for: params)
    }
    func didFail(with error: BaseError, for params: [String : AnyHashable]) {
        delegate?.didFail(with: error, for: params)
    }
}

//MARK:- Helpers
enum ApiStatus {
    case inProgress, success, error(with: BaseError), contentOver, unknown
}
