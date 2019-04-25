//
//  ChatVC.swift
//  ChatSocket
//
//  Created by Alex Manukyan on 4/22/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    var roomName: String!
    
    var textInputView: TextInputView!
    
    var collectionView: UICollectionView!
    let cellID: String = "ChatCellID"
    var cvContentInset = UIEdgeInsets(top: 8, left: 0, bottom: 50, right: 0)
    
    var messages = [Message]()
    
    var bottomPadding: CGFloat = 0
    let textInputViewHeigh: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        self.title = roomName
        
        
        SocketIOManager.shared.listenToNewMessage { (result) in
            switch result {
            case .success(let message):
                message.text = "\(message.text!) [Remote]"
                self.addMessage(message: message)
            case .failure(let error):
                print("Error:", error)
            }
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification,object: nil)
        
        prepareView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // TODO
        if #available(iOS 11.0, *) {
            bottomPadding = view.safeAreaInsets.bottom
            textInputView.frame.origin.y = view.frame.height - textInputViewHeigh - bottomPadding
            
            let cvHeight = view.frame.height - self.topbarHeight - textInputViewHeigh - bottomPadding
            collectionView.frame.size.height = cvHeight
        }
    }
    
    
}

extension ChatVC {
    
    func prepareView(){
        
        // Chat CollectionView
        let cvlayout = UICollectionViewFlowLayout()
        let cvHeight = view.frame.height - self.topbarHeight - textInputViewHeigh
        let cvFrame = CGRect(x: 0, y: self.topbarHeight, width: view.frame.width, height: cvHeight)
        collectionView = UICollectionView(frame: cvFrame, collectionViewLayout: cvlayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.contentInset = cvContentInset
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(collectionViewTapped)))
        
        view.addSubview(collectionView)
        
        // Text Input View
        
        let textInputViewOriginY = view.frame.height - textInputViewHeigh
        textInputView = TextInputView(frame: CGRect(x: 0, y: textInputViewOriginY , width: view.frame.width, height: textInputViewHeigh))
        textInputView.textInputDelegate = self
        view.addSubview(textInputView)
    }
    
    @objc func collectionViewTapped(){
        textInputView.textField.resignFirstResponder()
    }
    
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
}

extension ChatVC{
    
    
    func addMessage(message: Message){
        messages.append(message)
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(item: self.messages.count - 1, section: 0), at: .bottom, animated: true)

    }
    
    func sendMessage(text: String){
        print("sendMessage: ", text)
        
        let message = Message()
        message.text = text
        message.username = title
        message.channelID = title
        message.userId = title
        SocketIOManager.shared.sendMessage(message: message)
        addMessage(message: message)
    }
}

extension ChatVC : TextInputDelegate {
    func didClickOnSend(text: String) {
        sendMessage(text: text)
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //print("textFieldDidEndEditing")
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}



// COLLECTION VIEW
extension ChatVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChatCell
        let message = messages[indexPath.row]
        cell.configure(message: message)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}

extension ChatVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = messages[indexPath.item]
        let profilePicWidth: CGFloat = 40
        let textLabelWidth = collectionView.frame.width - profilePicWidth - 20
        let textFont = Globals.fontDefault!
        let textHeight = message.text?.height(withConstrainedWidth: textLabelWidth, font: textFont)
        let cellHeight = textHeight! + 20 + 10 + 5 + 5
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


// MARK:  KEYBOARD
extension ChatVC{
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.textInputView.frame.origin.y = self.view.frame.height - self.textInputView.frame.height - bottomPadding
                
                self.collectionView.contentInset = self.cvContentInset
            
            } else {
                self.textInputView.frame.origin.y = self.view.frame.height - self.textInputView.frame.height - (endFrame?.size.height)!
                
                var inset = self.cvContentInset
                inset.bottom += (endFrame?.size.height)!
                self.collectionView.contentInset = inset
            }
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}


