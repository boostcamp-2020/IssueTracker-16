//
//  LabelInteractor.swift
//  IssueTracker
//
//  Created by woong on 2020/10/28.
//

import Foundation

protocol LabelBusinessLogic {
    func request(endPoint: LabelEndPoint, completionHandler: @escaping ([Label]) -> Void)
}

class LabelInteractor: LabelBusinessLogic {
    
    func request(endPoint: LabelEndPoint, completionHandler: @escaping ([Label]) -> Void) {
        APIManger.request(endPoint: endPoint) { (data: [Label]?) in
            guard let data = data else {
                completionHandler([])
                return
            }
            completionHandler(data)
        }
    }
}
