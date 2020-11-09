//
//  IssueDetailInteractor.swift
//  IssueTracker
//
//  Created by woong on 2020/11/09.
//

import Foundation
import NetworkService

protocol IssueDetailBusinessLogic {
    func request<T: Codable>(endPoint: IssueEndPoint, completionHandler: @escaping (T?) -> Void)
}

class IssueDetailInteractor: IssueBusinessLogic {
    func request<T>(endPoint: IssueEndPoint, completionHandler: @escaping (T?) -> Void) where T : Decodable, T : Encodable {
        NetworkManager.shared.request(endPoint: endPoint) { (data: T?, response: NetworkManager.Response?) in
            guard response == nil else {
                debugPrint(response)
                return
            }
            completionHandler(data)
        }
    }
}
