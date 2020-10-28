//
//  EndPointType.swift
//  NetworkService
//
//  Created by woong on 2020/10/28.
//

import Foundation

public protocol EndPointType {
    var baseURL: URL? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
