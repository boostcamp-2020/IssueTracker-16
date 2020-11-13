//
//  UserInteractor.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/12.
//

import Foundation
import NetworkService

protocol UserBusinessLogic {
    func request<T: Codable>(endPoint: UserEndPoint, completionHandler: @escaping (T?) -> Void)
}

class AssignmentInteractor: UserBusinessLogic {
    func request<T: Codable>(endPoint: UserEndPoint, completionHandler: @escaping (T?) -> Void) {
        NetworkManager.shared.request(endPoint: endPoint) { (data: T?, response: NetworkManager.Response?) in
            guard response == nil else {
                debugPrint(response)
                return
            }
            completionHandler(data)
        }
    }
}
