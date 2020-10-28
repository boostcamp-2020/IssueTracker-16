//
//  IssueTrackerAPI.swift
//  IssueTracker
//
//  Created by woong on 2020/10/28.
//

import Foundation
import NetworkService

final class IssueTrackerAPI {
    func requestLabel(endPoint: LabelEndPoint, completionHandler: @escaping (Data?) -> Void) {
        NetworkManager.shared.request(endPoint: endPoint) { (data: Data?, response: NetworkManager.NetworkResponse?) in
            guard response == nil else {
                return
            }
            completionHandler(data)
        }
    }
    
    func requestMilestone(endPoint: MilestoneEndPoint, completionHandler: @escaping (Data?) -> Void) {
        NetworkManager.shared.request(endPoint: endPoint) { (data: Data?, response: NetworkManager.NetworkResponse?) in
            guard response == nil else {
                return
            }
            completionHandler(data)
        }
    }
}
