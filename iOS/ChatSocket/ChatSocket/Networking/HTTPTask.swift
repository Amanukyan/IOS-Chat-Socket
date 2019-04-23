//
//  HTTPTask.swift
//  Login
//
//  Created by Alex Manukyan on 4/6/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//


import Foundation

public typealias HTTPHeaders = [String:String]

/// Represents an HTTP task.
public enum HTTPTask {
    
    /// A request with no additional data.
    case requestPlain
    
    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
    
}
