//
//  MilestoneInteractor.swift
//  IssueTracker
//
//  Created by woong on 2020/11/02.
//

import Foundation
import NetworkService

protocol MilestoneBusinessLogic {
    func request<T: Codable>(endPoint: MilestoneEndPoint, completionHandler: @escaping (T?) -> Void)
}

class MilestoneInteractor: MilestoneBusinessLogic {
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
