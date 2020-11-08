//
//  Request.swift
//  NetworkService
//
//  Created by woong on 2020/10/29.
//

import Foundation

open class Request {
    
    // MARK: - Constants
    
    enum Result<String>{
        case success
        case failure(String)
    }
    
    public enum NetworkResponse: String {
        case success
        case badURL = "Bad URL"
        case authenticationError = "You need to be authenticated first."
        case badRequest = "Bad request"
        case outdated = "The url you requested is outdated."
        case failed = "Network request failed."
        case noData = "Response returned with no data to decode."
        case unableToDecode = "We could not decode the response."
    }

    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    enum RequestTask {
        case data
        case download
    }
    
    enum RequestError: Error {
        case badURL
        case failedParameterEncode(Error)
    }
    
    // MARK: - Properties
    
    var task: URLSessionTask?
    var request: URLRequest?
    var session: URLSession
    var error: RequestError?
    
    // MARK: - Intialize
    
    init(session: URLSession, task: RequestTask) {
        self.session = session
    }
    
    // MARK: - Methods
    
    func configureRequest(for endPoint: EndPointType) {
        guard var baseURL = endPoint.baseURL else {
            self.error = .badURL
            debugPrint(error)
            return
        }
        
        if !endPoint.path.isEmpty {
            baseURL.appendPathComponent(endPoint.path)
        }
        
        var request = URLRequest(url: baseURL,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = endPoint.httpMethod.rawValue
        
        do {
            switch endPoint.task {
                case .request:
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                case let .requestParameters(bodyParameters,
                                            bodyEncoding,
                                            urlParameters):
                    try configureParameters(bodyParameters: bodyParameters,
                                        bodyEncoding: bodyEncoding,
                                        urlParameters: urlParameters,
                                        request: &request)
                case let .requestParametersAndHeaders(bodyParameters,
                                                      bodyEncoding,
                                                      urlParameters,
                                                      additionHeaders):
                    try configureParameters(bodyParameters: bodyParameters,
                                        bodyEncoding: bodyEncoding,
                                        urlParameters: urlParameters,
                                        additionHeaders: additionHeaders,
                                        request: &request)
            }
        } catch {
            self.error = .failedParameterEncode(error)
        }
        
        self.request = request
    }
    
    // MARK: Private
    
    private func configureParameters(bodyParameters: Parameters?,
                             bodyEncoding: ParameterEncoding,
                             urlParameters: Parameters?,
                             additionHeaders: HTTPHeaders? = nil,
                             request: inout URLRequest) throws {
        request.allHTTPHeaderFields = additionHeaders
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
                                    urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
}
