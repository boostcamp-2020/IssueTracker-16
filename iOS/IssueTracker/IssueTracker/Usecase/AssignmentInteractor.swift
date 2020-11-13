//
//  AssignmentInteractor.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/12.
//

import Foundation
import NetworkService

protocol AssignmentBusinessLogic {
    func request<T: Codable>(endPoint: UserEndPoint, completionHandler: @escaping (T?) -> Void)
    func request<T: Codable>(endPoint: LabelEndPoint, completionHandler: @escaping (T?) -> Void)
    func request<T: Codable>(endPoint: MilestoneEndPoint, completionHandler: @escaping (T?) -> Void)
}

class AssignmentInteractor: AssignmentBusinessLogic {
    func request<T: Codable>(endPoint: UserEndPoint, completionHandler: @escaping (T?) -> Void) {
        NetworkManager.shared.request(endPoint: endPoint) { (data: T?, response: NetworkManager.Response?) in
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
    func request<T: Codable>(endPoint: MilestoneEndPoint, completionHandler: @escaping (T?) -> Void) {
        NetworkManager.shared.request(endPoint: endPoint) { (data: T?, response: NetworkManager.Response?) in
            guard response == nil else {
                debugPrint(response)
                return
            }
            completionHandler(data)
        }
    }
}
