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
    case delete(id: Int)
    case update(id: Int, body: Parameters)
    case commentCreate(body: Parameters)
    case commentUpdate(id: Int, body: Parameters)
    
    var baseURL: URL? {
        return URL(string: "http://issue-tracker.kro.kr:3000/api/")
    }
    
    var path: String {
        switch self {
            case .list: return "issues"
            case .issue(let id): return "issues/\(id)"
            case .create: return "issues"
            case .delete(let id): return "issues/\(id)"
            case .update(let id, _):
                return "issues/\(id)"
            case .commentCreate:
                return "comments"
            case .commentUpdate(let id, _):
                return "comments/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            case .list: return .get
            case .issue: return .get
            case .create: return .post
            case .delete: return .delete
            case .update: return .patch
            case .commentCreate: return .post
            case .commentUpdate: return .put
        }
    }
    
    var task: HTTPTask {
        switch self {
            case .list, .issue, .delete(_): return .request
            case .create(let data),
                 .update(_, let data),
                 .commentCreate(let data),
                 .commentUpdate(_, let data):
                return .requestParameters(bodyParameters: data,
                                        bodyEncoding: .jsonEncoding,
                                        urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
