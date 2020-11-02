//
//  IssueInteractor.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/02.
//

import Foundation

protocol IssueBusinessLogic {
    func request(endPoint: IssueEndPoint, completionHandler: @escaping ([Issue]) -> Void)
}

class IssueInteractor: IssueBusinessLogic {
    func request(endPoint: IssueEndPoint, completionHandler: @escaping ([Issue]) -> Void) {
        APIManager.request(endPoint: endPoint) { (data: [Issue]?) in
            guard let data = data else {
                completionHandler([])
                return
            }
            completionHandler(data)
        }
    }
}
