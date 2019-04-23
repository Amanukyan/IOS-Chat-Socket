//
//  UserService.swift
//  Login
//
//  Created by Alex Manukyan on 4/16/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import Foundation

class UserService {
    
    static func getUser(completion: @escaping (Result<[User],Error>)->()) {
        let endpoint = UserApi.getUsers
        ApiClient.shared.perfomRequest(endPoint: endpoint) { (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                for user in users {
                    print("user= ", user.username ?? "nil")
                }
                completion(.success(users))
            case .failure(let error):
                print("Error: ", error)
                completion(.failure(error))
            }
        }
    }
    
}
