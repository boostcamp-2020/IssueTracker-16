//
//  IssueInteractor.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/02.
//

import Foundation
import NetworkService

protocol IssueBusinessLogic {
    func request<T: Codable>(endPoint: IssueEndPoint, completionHandler: @escaping (T?) -> Void)
}

class IssueInteractor: IssueBusinessLogic {
    
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
