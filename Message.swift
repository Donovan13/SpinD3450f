//
//  Message.swift
//  Spinder
//
//  Created by Mingu Chu on 5/4/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import Foundation
import Firebase

class Message {
    private var userRef: Firebase!
    
    private var _userKey: String!
    private var _senderId: String!
    private var _senderName: String!
    private var _receieverId: String!
    private var _receiverName: String!
    private var _text: String!
    
    var userKey: String {
        return _userKey
    }
    var senderId: String {
        return _senderId
    }
    var senderName: String {
        return _senderName
    }
    var receieverId: String {
        return _receieverId
    }
    var recieverName: String {
        return _receiverName
    }
    var text: String {
        return _text
    }
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._userKey = key
        
        if let sendId = dictionary["senderId"] as? String {
            self._senderId = sendId
        }
        if let sendName = dictionary["senderName"] as? String {
            self._senderName = sendName
        }
        if let receieveId = dictionary["receieverId"] as? String {
            self._receieverId = receieveId
        }
        if let receieveName = dictionary["receieverName"] as? String {
            self._receiverName = receieveName
        }
    }
    
    
    
    
    
    
}

