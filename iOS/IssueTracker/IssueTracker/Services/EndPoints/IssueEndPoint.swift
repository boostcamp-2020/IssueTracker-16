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
    case issue(id: Int)
    case create(body: Parameters)
    case delete(body: Parameters)
    case update(id: Int, body: Parameters)
    
    var baseURL: URL? {
        return URL(string: "http://issue-tracker.kro.kr:3000/api/")
    }
    
    var path: String {
        switch self {
            case .list: return "issues"
            case .issue(let id): return "issues/\(id)"
            case .create, .delete: return ""
            case .update(let id, _):
                return "issues/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            case .list: return .get
            case .issue: return .get
            case .create: return .post
            case .delete: return .delete
            case .update: return .put
        }
    }
    
    var task: HTTPTask {
        switch self {
            case .list, .issue: return .request
            case .create(let data), .delete(let data), .update(_, let data):
                return .requestParameters(bodyParameters: data,
                                        bodyEncoding: .jsonEncoding,
                                        urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
            case .list, .issue, .create, .delete, .update: return nil
        }
    }
}
