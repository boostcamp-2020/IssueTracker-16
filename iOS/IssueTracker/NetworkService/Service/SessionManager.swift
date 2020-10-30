//
//  SessionManager.swift
//  NetworkService
//
//  Created by woong on 2020/10/29.
//

import Foundation

class SessionManager {
    
    enum RequestTask {
        case data
        case download
    }
    
    public let session: URLSession
    
    static let `default`: SessionManager = {
        let configuration = URLSessionConfiguration.default
        
        return SessionManager(configuration: configuration)
    }()
    
    init(configuration: URLSessionConfiguration, delegate: URLSessionDelegate? = nil, delegateQueue: OperationQueue? = nil) {
        self.session = .init(configuration: configuration, delegate: delegate, delegateQueue: delegateQueue)
    }
    
    func request(for endPoint: EndPointType) -> DataRequest {
        
        let request = DataRequest(session: session, task: .data)
        request.configureRequest(for: endPoint)
        
        return request
    }
}
