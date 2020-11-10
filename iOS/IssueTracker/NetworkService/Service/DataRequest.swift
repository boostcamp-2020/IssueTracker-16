//
//  DataRequest.swift
//  NetworkService
//
//  Created by woong on 2020/10/29.
//

import Foundation

open class DataRequest: Request {
    
    @discardableResult
    func responseData(completionHandler: @escaping (Data?, NetworkResponse?) -> Void) -> Self {
        guard let request = request else {
            return self
        }
        
        session.dataTask(with: request, completionHandler: { (data, response, error) in

            guard error == nil else {
                completionHandler(nil, .failed)
                return
            }

            guard let data = data else {
                completionHandler(nil, .noData)
                return
            }
            
            completionHandler(data, nil)
        }).resume()
        
        return self
    }
    
}
