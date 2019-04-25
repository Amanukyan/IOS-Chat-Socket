//
//  SocketManager.swift
//  ChatSocket
//
//  Created by Alex Manukyan on 4/22/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    
    var socket: SocketIOClient!
    var manager: SocketManager!
    
    override init() {
        super.init()
        
        manager = SocketManager(socketURL: URL(string: Globals.baseUrl)!, config: [.log(false),
                                                                                   .compress,
                                                                                   .reconnects(true),
                                                                                   .reconnectAttempts(-1),
                                                                                   .reconnectWait(1)
            ])
        socket = manager.defaultSocket
        
        listenToDefaultEvents()
    }
}

extension SocketIOManager{
    
    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func listenToDefaultEvents(){
        
        socket.on(clientEvent: .ping) {data, ack in
            //print("Socket ping")
        }
        
        socket.on(clientEvent: .connect) {data, ack in
            print("Socket connected:", data)
            
        }
        
        socket.on(clientEvent: .disconnect) {data, ack in
            print("Socket Disconnected:", data)
        }
        
        socket.on(clientEvent: .statusChange) {data, ack in
            print("Socket status Change:", data)
        }
        
        socket.on(clientEvent: .reconnectAttempt) {data, ack in
            print("Socket  reconnectAttempt:", data)
        }
        
        socket.on(clientEvent: .reconnect) {data, ack in
            print("Socket reconnect:", data)
        }
        
        socket.on(clientEvent: .error) {data, ack in
            print("Socket Error:", data)
        }
    }
}

extension SocketIOManager{
    func sendMessage(message: Message) {
        
        do {
            let jsonData = try JSONEncoder().encode(message)
//            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            print("JSON=",json)
            socket.emit("message", json!)
            
        } catch let error{
            print("ERROR:", error.localizedDescription)
        }
    }

    func listenToNewMessage(completion: @escaping (Result<Message, Error>) -> ()) {
        
        socket.on("message") { (dataArray, ack) in
            print("data=", dataArray[0])
            do {
                let requestDataObject = try! JSONSerialization.data(withJSONObject: dataArray[0], options: .prettyPrinted)
                let message = try JSONDecoder().decode(Message.self, from: requestDataObject)
                completion(.success(message))
            } catch let error {
                print("ERROR:", error.localizedDescription)
                completion(.failure(error))
            }
        
        }
    }
}

