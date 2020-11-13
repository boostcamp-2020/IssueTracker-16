//
//  MilestoneEndPoint.swift
//  IssueTracker
//
//  Created by woong on 2020/10/28.
//

import Foundation
import NetworkService

enum MilestoneEndPoint: EndPointType {
    
    case list
    case create(body: Parameters)
    case delete(id: Int)
    case update(id: Int, body: Parameters)
    case assign(issueID: Int, body: Parameters)
    
    var baseURL: URL? {
        return URL(string: "http://issue-tracker.kro.kr:3000/api/")
    }
    
    var path: String {
        switch self {
        case .list, .create:
            return "milestones"
        case .update(let id, _), .delete(let id):
            return "milestones/\(id)"
        case .assign(let id, _):
            return "issues/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            case .list: return .get
            case .create: return .post
            case .delete: return .delete
            case .update: return .patch
            case .assign: return .patch
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .list, .delete(_): return .request
        case .create(let data), .update(_, let data):
            return .requestParameters(bodyParameters: data,
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: nil)
        case .assign(_, let data):
            return .requestParameters(bodyParameters: data,
                                    bodyEncoding: .jsonEncoding,
                                    urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
