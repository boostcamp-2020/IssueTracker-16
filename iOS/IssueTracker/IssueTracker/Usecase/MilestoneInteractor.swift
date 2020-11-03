//
//  MilestoneInteractor.swift
//  IssueTracker
//
//  Created by woong on 2020/11/02.
//

import Foundation

protocol MilestoneBusinessLogic {
    func request(endPoint: MilestoneEndPoint, completionHandler: @escaping ([Milestone]) -> Void)
}

class MilestoneInteractor: MilestoneBusinessLogic {
    func request(endPoint: MilestoneEndPoint, completionHandler: @escaping ([Milestone]) -> Void) {
        APIManager.request(endPoint: endPoint) { (data: [Milestone]?) in
            guard let data = data else {
                completionHandler([])
                return
            }
            completionHandler(data)
        }
    }
}
