//
//  UserCell.swift
//  Login
//
//  Created by Alex Manukyan on 4/10/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    //Views
    var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        layer.cornerRadius = 10
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UserCell{
    func prepareView(){
        
        // text Label
        textLabel = UILabel()
        textLabel.frame = CGRect(x: 0, y: 0, width: frame.width * 0.9, height: frame.height)
        textLabel.center.x = frame.width/2
        textLabel.frame.origin.y = frame.height - textLabel.frame.height
        textLabel.textColor = UIColor.black
        textLabel.textAlignment = .left
        textLabel.font = Globals.fontHeavy?.withSize(20)
        addSubview(textLabel)
        
    }
}

