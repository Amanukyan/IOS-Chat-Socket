//
//  ApiClient.swift
//  Login
//
//  Created by Alex Manukyan on 4/3/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import Foundation


class ApiClient {
    
    static var shared = ApiClient()
    
    func perfomRequest<T:Decodable>(endPoint: EndPoint, completion: @escaping (Result<T, Error>)->()) {
        let urlRequest = buildRequest(from: endPoint)
        
        if urlRequest == nil {
            return
        }
        
        RequestLogger.log(request: urlRequest!)
        
        URLSession.shared.dataTask(with: urlRequest!) { (data, response, error) in
            // TODO Req status
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(decoded))
            } catch let error {
                print("ERROR:", error.localizedDescription)
                completion(.failure(error))
            }
            }.resume()
    }
    
    
    fileprivate func buildRequest(from route: EndPoint) -> URLRequest? {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.method.rawValue
        addAdditionalHeaders(route.headers, request: &request)
        do {
            switch route.task {
            case .requestParameters(let parameters, let encoding):
                try self.configureParameters(parameters: parameters, encoding: encoding, request: &request)
            case .requestPlain:
                return request
            }
            return request
        } catch let error {
            print("Error:", error)
            return nil
        }
    }
    
    fileprivate func configureParameters(parameters: Parameters?, encoding: ParameterEncoding, request: inout URLRequest) throws {
        do {
            try encoding.encode(urlRequest: &request, parameters: parameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    
}
