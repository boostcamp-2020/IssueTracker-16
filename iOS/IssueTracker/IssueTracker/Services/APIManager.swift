//
//  IssueTrackerAPI.swift
//  IssueTracker
//
//  Created by woong on 2020/10/28.
//

import Foundation
import NetworkService

final class APIManager {
    static func request<T: Decodable>(endPoint: EndPointType, completionHandler: @escaping (T?) -> Void) {
        NetworkManager.shared.request(endPoint: endPoint) { (data: T?, response: NetworkManager.Response?) in
            guard response == nil else {
                debugPrint(response)
                return
            }
            completionHandler(data)
        }
    }
    
    static func request(endPoint: EndPointType, completionHandler: @escaping (Data?) -> Void) {
        NetworkManager.shared.request(endPoint: endPoint) { (data: Data?, response: NetworkManager.Response?) in
            guard response == nil else {
                debugPrint(response)
                return
            }
            completionHandler(data)
        }
    }
}
