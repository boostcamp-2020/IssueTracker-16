//
//  LabelInteractor.swift
//  IssueTracker
//
//  Created by woong on 2020/10/28.
//

import Foundation
import NetworkService

protocol LabelBusinessLogic {
    func request<T: Codable>(endPoint: LabelEndPoint, completionHandler: @escaping (T?) -> Void)
    func request(endPoint: LabelEndPoint, completionHandler: @escaping (Data?) -> Void)
}

class LabelInteractor: LabelBusinessLogic {
    
    func request(endPoint: LabelEndPoint, completionHandler: @escaping (Data?) -> Void) {
        NetworkManager.shared.request(endPoint: endPoint) { (data: Data?, response: NetworkManager.Response?) in
            guard response == nil else {
                debugPrint(response)
                return
            }
            completionHandler(data)
        }
    }
    
    func request<T>(endPoint: LabelEndPoint, completionHandler: @escaping (T?) -> Void) where T : Decodable, T : Encodable {
        NetworkManager.shared.request(endPoint: endPoint) { (data: T?, response: NetworkManager.Response?) in
            guard response == nil else {
                debugPrint(response)
                return
            }
            completionHandler(data)
        }
    }
}
