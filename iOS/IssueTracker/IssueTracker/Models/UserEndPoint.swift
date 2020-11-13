//
//  UserEndPoint.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/12.
//

import Foundation
import NetworkService

enum UserEndPoint: EndPointType {
    
    case list
    case assign(body: Parameters)
    
    var baseURL: URL? {
        return URL(string: "http://issue-tracker.kro.kr:3000/api/")
    }
    
    var path: String {
        switch self {
            case .list: return "users"
            case .assign: return "assignments"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            case .list: return .get
            case .assign: return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
            case .list: return .request
            case .assign(let data):
                return .requestParameters(bodyParameters: data,
                                          bodyEncoding: .jsonEncoding,
                                          urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
