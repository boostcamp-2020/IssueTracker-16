//
//  DonwloadRequest.swift
//  NetworkService
//
//  Created by woong on 2020/10/29.
//

import Foundation

open class DownloadRequest: Request {
    
    @discardableResult
    func responseData(completionHandler: @escaping (URL?, NetworkResponse?) -> Void) -> Self {
        
        guard let request = request else {
            return self
        }
        
        session.downloadTask(with: request, completionHandler: { (url, response, error) in
            guard error != nil else {
                completionHandler(nil, .failed)
                return
            }

            guard let url = url else {
                completionHandler(nil, .noData)
                return
            }
            
            completionHandler(url, nil)
        }).resume()
        
        return self
    }
}
