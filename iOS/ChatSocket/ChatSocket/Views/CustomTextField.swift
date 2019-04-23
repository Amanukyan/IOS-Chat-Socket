//
//  CustomTextField.swift
//  Login
//
//  Created by Alex Manukyan on 4/10/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    
    var paddingLeft: CGFloat = 20
    var paddingRight: CGFloat = 20
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: "VisbyRoundCF-Bold", size: 15)
        self.textColor = UIColor.white
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
}
