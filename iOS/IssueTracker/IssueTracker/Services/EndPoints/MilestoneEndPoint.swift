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
    case delete(body: Parameters)
    case update(body: Parameters)
    
    var baseURL: URL? {
        switch self {
            #warning("base url 추가")
            case .list, .create, .delete, .update: return nil
        }
    }
    
    var path: String {
        switch self {
            case .list, .create, .delete, .update: return ""
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
            case .create(let data), .delete(let data), .update(let data):
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
