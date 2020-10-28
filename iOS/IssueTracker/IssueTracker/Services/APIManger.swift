//
//  IssueTrackerAPI.swift
//  IssueTracker
//
//  Created by woong on 2020/10/28.
//

import Foundation
import NetworkService

final class APIManger {
    static func request<T: Decodable>(endPoint: EndPointType, completionHandler: @escaping (T?) -> Void) {
        NetworkManager.shared.request(endPoint: endPoint) { (data: T?, response: NetworkManager.NetworkResponse?) in
            guard response == nil else {
                return
            }
            completionHandler(data)
        }
    }
}
