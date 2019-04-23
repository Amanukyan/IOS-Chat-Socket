//
//  TextInputView.swift
//  ChatSocket
//
//  Created by Alex Manukyan on 4/22/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import UIKit

protocol TextInputDelegate:class, UITextFieldDelegate {
    func didClickOnSend(text: String)
}

class TextInputView: UIView {
    
    var textField: CustomTextField!
    var sendButton: UIButton!
    
    weak var textInputDelegate: TextInputDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addBorder(toSide: .Top, withColor: UIColor.black.cgColor, andThickness: 1)
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension TextInputView {
    
    func prepareView(){
        // TextField
        textField = CustomTextField(frame: CGRect(x:25, y: 0, width: frame.width * 0.7, height: frame.height * 0.8))
        textField.center.y = frame.height/2
        textField.placeholder = "Write something"
        textField.textColor = UIColor.black
        textField.attributedPlaceholder = NSAttributedString(string:"Write something", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white:0, alpha:0.5)])
        textField.returnKeyType = .send
        textField.backgroundColor = UIColor(hexString: "FCFCFC")
        textField.layer.cornerRadius = textField.frame.height/2
        textField.layer.borderColor = UIColor(hexString: "F5F5F5").cgColor
        textField.layer.borderWidth = 1
        textField.enablesReturnKeyAutomatically = true
        //textField.autocorrectionType = .no
        addSubview(textField)
        
        sendButton = UIButton(frame: CGRect(x: 0, y: 0, width: textField.frame.height, height: textField.frame.height))
        sendButton.center.y = textField.center.y
        sendButton.center.x = (frame.width + textField.frame.maxX) / 2
        sendButton.layer.cornerRadius = sendButton.frame.height/2
        sendButton.backgroundColor = Globals.colors.blue
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        addSubview(sendButton)
    }
    
}

extension TextInputView {
    @objc func sendButtonClicked(){
        textInputDelegate.didClickOnSend(text: textField.text ?? "")
    }
}
