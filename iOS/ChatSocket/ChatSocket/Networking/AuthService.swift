//
//  AuthService.swift
//  Login
//
//  Created by Alex Manukyan on 4/16/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import Foundation


class AuthService {
    
    static func register(username:String, password: String, completion: @escaping (Result<String,Error>)->()){
        
        let endpoint = AuthApi.register(username: username, password: password)
        ApiClient.shared.perfomRequest(endPoint: endpoint) { (result: Result<[String: String], Error>) in
            switch result {
            case .success:
                self.login(username: username, password: password, completion: completion)
            case .failure(let error):
                print("Error: ", error)
            }
        }
        
        return;
    }
    
    
    static func login(username:String, password: String, completion: @escaping (Result<String,Error>)->()){
        
        let endpoint = AuthApi.login(username: username, password: password)
        ApiClient.shared.perfomRequest(endPoint: endpoint) { (result: Result<[String: String], Error>) in
            switch result {
            case .success(let json):
                let token = json["token"]
                AuthManager.shared.store(token: token!)
                completion(.success(token!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
