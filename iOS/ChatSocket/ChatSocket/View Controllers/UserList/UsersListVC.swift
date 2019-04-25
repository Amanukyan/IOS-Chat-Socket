//
//  HomeViewController.swift
//  Login
//
//  Created by Alex Manukyan on 4/6/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import UIKit

class UserListVC: UIViewController {
    
    var collectionView: UICollectionView!
    fileprivate let cellIdentifier = "cell"
    var cvContentInset = UIEdgeInsets(top: 8, left: 0, bottom: 50, right: 0)
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Globals.colors.yellow
        print("HomeViewController - View did load")
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = logoutButton
        self.title = "Users"
        
        
        UserService.getUser { [weak self] (result) in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self?.users = users
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("FAILURE:", error)
            }
        }
        
        prepareView()
    }
    
    @objc func logout(){
        AuthManager.shared.logout()
        let vc = LoginVC()
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = vc
    }
    
    func prepareView(){
        
        let cvRect = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        // Setting of UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width , height: cvRect.height)
        let leftRightInstet:CGFloat = 0 //self.bounds.width * 0.05
        layout.sectionInset = UIEdgeInsets(top: 30, left: leftRightInstet, bottom: 0, right: leftRightInstet)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: cvRect , collectionViewLayout: layout)
        //collectionView = GeminiCollectionView(frame: cvRect , collectionViewLayout: layout)
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.backgroundColor = UIColor.clear
        
        //collectionView.layer.cornerRadius = 7
        self.view.addSubview(collectionView)
        
    }
}
// COLLECTION VIEW
extension UserListVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! UserCell
        
        let user = users[indexPath.row]
        cell.textLabel.text = user.username
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = users[indexPath.item]
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.pushIn(){ [weak self] _ in
            let chatVC = ChatVC()
            chatVC.roomName = user.username
            self?.navigationController?.pushViewController(chatVC, animated: true)
        }
    }
    
    
}

extension UserListVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width * 0.8, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

