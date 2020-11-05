//
//  IssueEndPoint.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/02.
//

import Foundation
import NetworkService

enum IssueEndPoint: EndPointType {
    
    case list
    case create(body: Parameters)
    case delete(body: Parameters)
    case update(id: Int, body: Parameters)
    
    var baseURL: URL? {
        switch self {
            case .list: return URL(string: "http://issue-tracker.kro.kr:3000/api/")
            case.create, .delete, .update: return nil
        }
    }
    
    var path: String {
        switch self {
            case .list: return "issues"
            case .create, .delete: return ""
            case .update(let id, _):
                return "issues/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            case .list: return .get
            case .create: return .post
            case .delete: return .delete
            case .update: return .put
        }
    }
    
    var task: HTTPTask {
        switch self {
            case .list: return .request
            case .create(let data), .delete(let data), .update(_, let data):
                return .requestParameters(bodyParameters: data,
                                        bodyEncoding: .jsonEncoding,
                                        urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
            case .list, .create, .delete, .update: return nil
        }
    }
}
