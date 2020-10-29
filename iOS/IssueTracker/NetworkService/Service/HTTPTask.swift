//
//  HTTPTask.swift
//  NetworkService
//
//  Created by woong on 2020/10/28.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters?,
                           additionHeaders: HTTPHeaders? = nil)
}
