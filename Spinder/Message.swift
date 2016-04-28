//
//  Message.swift
//  Spinder
//
//  Created by Mingu Chu on 4/27/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import Foundation



class Message: NSObject, JSQMessageData {
    var text_: String
    var sender_: String
    var date_: NSDate
    var receiever_: String
    
    convenience init(text: String?, sender: String?) {
        self.init(text: text, sender: sender)
    }
    
    init(text:String?, sender: String?, receiever: String?) {
        self.text_ = text!
        self.sender_ = sender!
        self.date_ = NSDate()
        self.receiever_ = receiever
    }
    
    func text() -> String! {
        return text_
    }
    
    func sender() -> String! {
        return sender_
    }
    
    func date() -> NSDate {
        return date_
    }
    
    func receiever() -> String! {
        return receiever_
    }
    
}

