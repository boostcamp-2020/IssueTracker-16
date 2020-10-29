//
//  NetworkManager.swift
//  NetworkService
//
//  Created by woong on 2020/10/28.
//

import Foundation

public class NetworkManager {
    
    public static let shared = { NetworkManager() }()
    
    public func request<T: Decodable>(endPoint: EndPointType, completion: @escaping (_ data: T?, _ response: NetworkResponse?) -> Void) {
        
        let (urlRequest, requestError) = configureRequest(for: endPoint)
        
        guard let request = urlRequest else {
            completion(nil, requestError)
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: { (data, response, error) in

            guard error == nil else {
                completion(nil, .failed)
                return
            }

            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, .unableToDecode)
            }
        }).resume()
    }
    
    public func request(endPoint: EndPointType, completion: @escaping (_ data: Data?, _ response: NetworkResponse?) -> Void) {
        
        let (urlRequest, requestError) = configureRequest(for: endPoint)
        
        guard let request = urlRequest else {
            completion(nil, requestError)
            return
        }

        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: { (data, response, error) in

            guard error == nil else {
                completion(nil, .failed)
                return
            }

            guard let data = data else {
                completion(nil, .noData)
                return
            }
            completion(data, nil)
        }).resume()
    }
    
    public func requestDownload(endPoint: EndPointType, completion: @escaping (_ url: URL?, _ response: NetworkResponse?) -> Void) {
        
        let (urlRequest, requestError) = configureRequest(for: endPoint)
        
        guard let request = urlRequest else {
            completion(nil, requestError)
            return
        }
        
        let session = URLSession.shared
        session.downloadTask(with: request) { (url, response, error) in
            guard error == nil else {
                completion(nil, .failed)
                return
            }

            guard let url = url else {
                completion(nil, .noData)
                return
            }
            completion(url, nil)
        }.resume()
    }
    
    private func configureRequest(for endPoint: EndPointType) -> (request: URLRequest?, error: NetworkResponse?) {
        guard var baseURL = endPoint.baseURL else {
            return (nil, .badURL)
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
                default: break
            }
        } catch {
            print("endPoint task Error: \(error)")
        }
        
        return (request, nil)
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    enum Result<String>{
        case success
        case failure(String)
    }

    public enum NetworkResponse:String {
        case success
        case badURL = "Bad URL"
        case authenticationError = "You need to be authenticated first."
        case badRequest = "Bad request"
        case outdated = "The url you requested is outdated."
        case failed = "Network request failed."
        case noData = "Response returned with no data to decode."
        case unableToDecode = "We could not decode the response."
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    
}
