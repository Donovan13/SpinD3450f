//
//  FirebaseService.swift
//  Spinder
//
//  Created by Mingu Chu on 4/19/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    
    static let firebaseSerivce = FirebaseService()
    
    var ref = Firebase(url: "https://spinder.firebaseio.com/")
    var userRef = Firebase(url: "https://spinder.firebaseio.com/users")
    var activeUserRef = Firebase(url: "https://spinder.firebaseio.com/activeUsers")
    
    var FirebaseRef: Firebase {
        return ref
    }
    
    var FirebaseUserRef: Firebase {
        return userRef
    }
    
    var FirebaseActiveUserRef: Firebase {
        return activeUserRef
    }
    
    var currentUserRef: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let currentUser = Firebase(url: "https://spinder.firebaseio.com/").childByAppendingPath("users").childByAppendingPath(userID)
        return currentUser
    }
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        userRef.childByAppendingPath(uid).setValue(user)
    }
    
    func postActiveUser(post: Dictionary<String,AnyObject>) {
        let firebaseNewPost = FirebaseActiveUserRef.childByAutoId()
        firebaseNewPost.setValue(post)
    }
}

