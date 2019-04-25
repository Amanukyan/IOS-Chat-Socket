//
//  Globals.swift
//  Login
//
//  Created by Alex Manukyan on 4/10/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import Foundation
import UIKit

class Globals {
    
    //static let baseUrl = "http://192.168.1.17:5000"
    static let baseUrl = "http://192.168.50.198:3000"
    
    static let infiniteScrollTriggerOffsetCellsCount = 5
    
    struct colors {
        
        static let red = UIColor(hexString: "FD4765")
        static let blue = UIColor(hexString: "1EEBD9")
        static let green = UIColor(hexString: "20E626")
        static let yellow = UIColor(hexString: "FFB31A")
        static let veryLightGray =  UIColor(hexString: "FAFAFA")
        static let dark = UIColor(hexString: "22304E")
    }
    
    static let fontDefault = UIFont(name: "VisbyRoundCF-Bold", size: 15)
    static let fontHeavy = UIFont(name: "VisbyRoundCF-Heavy", size: 15)
    
    
}
