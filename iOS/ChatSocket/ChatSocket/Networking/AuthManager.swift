//
//  AuthToken.swift
//  Login
//
//  Created by Alex Manukyan on 4/15/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import Foundation

struct AuthManager {
    static let shared = AuthManager()
    var userDefault = UserDefaults.standard
    var tokenKey = "token"
    
    var token: String? {
        return userDefault.string(forKey: tokenKey)
    }
    
    var tokenWithBearer: String? {
        guard let token = userDefault.string(forKey: tokenKey) else { return nil }
        return "Bearer \(token)"
    }
    
    var isLoggedIn: Bool {
        return userDefault.string(forKey: tokenKey) != nil 
    }
    
    func store(token: String) {
        userDefault.set(token, forKey: tokenKey)
    }
    

    func logout() {
        userDefault.set(nil, forKey: tokenKey)
    }
}

