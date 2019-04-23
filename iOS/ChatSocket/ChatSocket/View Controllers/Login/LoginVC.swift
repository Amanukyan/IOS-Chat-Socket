//
//  ViewController.swift
//  Login
//
//  Created by Alex Manukyan on 3/31/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    var nameTextField: CustomTextField!
    var passwordTextField: CustomTextField!
    var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Globals.colors.yellow
        prepareView()
    
    }
    
    func prepareView(){
        // TextField
        nameTextField = CustomTextField(frame: CGRect(x:0, y: 100, width: view.frame.width * 0.6, height: 50))
        nameTextField.center.x = view.frame.width/2
        nameTextField.placeholder = "Name"
        nameTextField.attributedPlaceholder = NSAttributedString(string:"Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        nameTextField.returnKeyType = .send
        nameTextField.textColor = UIColor.black
        nameTextField.backgroundColor = UIColor.white
        nameTextField.layer.cornerRadius = nameTextField.frame.height/2
        nameTextField.layer.borderColor = UIColor(hexString: "F5F5F5").cgColor
        nameTextField.layer.borderWidth = 1
        nameTextField.enablesReturnKeyAutomatically = true
        //textField.autocorrectionType = .no
        view.addSubview(nameTextField)
        
        passwordTextField = CustomTextField(frame: CGRect(x:0, y: nameTextField.frame.maxY + 10, width: view.frame.width * 0.6, height: 50))
        passwordTextField.center.x = view.frame.width/2
        passwordTextField.placeholder = "Password"
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Pasword", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTextField.returnKeyType = .send
        passwordTextField.textColor = UIColor.black
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.layer.cornerRadius = nameTextField.frame.height/2
        passwordTextField.layer.borderColor = UIColor(hexString: "F5F5F5").cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.enablesReturnKeyAutomatically = true
        //textField.autocorrectionType = .no
        view.addSubview(passwordTextField)
        
        
        loginButton = UIButton(frame: CGRect(x:0, y: passwordTextField.frame.maxY + 10, width: view.frame.width * 0.6, height: 50))
        loginButton.center.x = view.frame.width/2
        loginButton.layer.cornerRadius = loginButton.frame.height/2
        loginButton.backgroundColor = UIColor(white: 0, alpha: 0.7)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    @objc func loginButtonClicked(){
        let username = nameTextField.text!
        let password = passwordTextField.text!
        AuthService.register(username: username, password: password) { (result) in
            switch result {
            case .success(let json):
                print("SUCCES:", json)
                DispatchQueue.main.async {
                    self.showHomeViewContoller()
                }
            case .failure(let error):
                print("FAILURE:", error)
            }
        }
    }
    
    func showHomeViewContoller(){
        let vc = UserListVC()
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let navVC = UINavigationController(rootViewController: vc)
        
        appDel.window?.rootViewController = navVC
    }
}

