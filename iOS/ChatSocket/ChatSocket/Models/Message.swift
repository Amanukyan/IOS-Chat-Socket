//
//  Message.swift
//  ChatSocket
//
//  Created by Alex Manukyan on 4/22/19.
//  Copyright © 2019 Alex Manukyan. All rights reserved.
//

import Foundation


class Message: Codable {
    
    var text: String?
    var username: String?
    var channelID: String?
    var userId: String?
}
