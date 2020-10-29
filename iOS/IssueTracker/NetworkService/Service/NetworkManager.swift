//
//  NetworkManager.swift
//  NetworkService
//
//  Created by woong on 2020/10/28.
//

import Foundation

public class NetworkManager {
    
    public typealias Response = Request.NetworkResponse
    
    let sessionManager: SessionManager
    
    public static let shared = {
        return NetworkManager(sessionManager: SessionManager(configuration: .default))
    }()
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    public func request(endPoint: EndPointType, completion: @escaping (_ data: Data?, _ response: Response?) -> Void) {
        
        let request = sessionManager.request(for: endPoint)
        
        request.responseData { (data: Data?, response: Request.NetworkResponse?) in
            completion(data, response)
        }
    }
    
    public func request<T: Decodable>(endPoint: EndPointType, completion: @escaping (_ data: T?, _ response: Response?) -> Void) {
        
        let request = sessionManager.request(for: endPoint)
        
        request.responseData { (data: Data?, response: Request.NetworkResponse?) in
            guard let data = data else {
                completion(nil, response)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let result = try decoder.decode(T.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, .unableToDecode)
            }
        }
    }
}
