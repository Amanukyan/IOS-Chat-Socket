//
//  ChatCell.swift
//  ChatSocket
//
//  Created by Alex Manukyan on 4/22/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import UIKit

class ChatCell: UICollectionViewCell {
    
    //Views
    var nameLabel: UILabel!
    var textLabel: UILabel!
    var profilePic: UIImageView!
    var timeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        textLabel.text = nil
    }
}

extension ChatCell{
    func prepareView(){
        
        // Profile Pic
        let imageSize = 40
        profilePic = UIImageView(frame: CGRect(x: 10, y: 10, width: imageSize, height: imageSize))
        profilePic.layer.cornerRadius = 10
        profilePic.backgroundColor = UIColor(white: 0, alpha: 0.2)
        addSubview(profilePic)
        
        // Name Label
        nameLabel = UILabel()
        nameLabel.frame = CGRect(x: profilePic.frame.maxX + 10, y: 10, width: frame.width - profilePic.frame.maxX - 10 , height: 20)
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.black
        nameLabel.font = Globals.fontHeavy
        addSubview(nameLabel)
        
        
        // text Label
        textLabel = UILabel()
        textLabel.frame =  CGRect(x: profilePic.frame.maxX + 10, y: 0, width: frame.width - profilePic.frame.maxX - 10 , height: 0)
        textLabel.frame.origin.y = nameLabel.frame.maxY + 5
        textLabel.frame.size.height = frame.height - textLabel.frame.origin.y - 5
        textLabel.textAlignment = .left
        textLabel.textColor = UIColor.black
        textLabel.font = Globals.fontDefault
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        addSubview(textLabel)
    }
    
    func configure(message: Message){
        textLabel.frame.origin.y = nameLabel.frame.maxY + 5
        textLabel.frame.size.height = frame.height - textLabel.frame.origin.y - 5
        
        textLabel.text = message.text
        nameLabel.text = "Name"
    }
}
