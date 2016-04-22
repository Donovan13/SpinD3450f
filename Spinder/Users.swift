//
//  Users.swift
//  Spinder
//
//  Created by Mingu Chu on 4/20/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import Foundation
import Firebase




class Users {
    private var userRef: Firebase!
    
    private var _userKey: String!
    private var _userName: String!
    private var _userAge: String!
    private var _userPhoto: String!
    private var _userDescription: String!
    private var _userGender: String!
    private var _userHomeTown: String!

    
    
    
    var userName: String {
        return _userName
    }
    
    var userAge: String {
        return _userAge
    }
    
    var userPhoto: String {
        return _userPhoto
    }
    
    var userGender: String {
        return _userGender
    }
    
    var userDescription: String {
        return _userDescription
    }
    
    var userHomeTown: String {
        return _userHomeTown
    }
    
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._userKey = key
        
        if let name = dictionary["name"] as? String {
            self._userName = name
        }
        if let photo = dictionary["profilePicture"] as? String {
            self._userPhoto = photo
        }
        if let age = dictionary["age"] as? String {
            self._userAge = age
        }
        if let description = dictionary["description"] as? String {
            self._userDescription = description
        }
        if let gender = dictionary["gender"] as? String {
            self._userGender = gender
        }
        if let homeTown = dictionary["homeTown"] as? String {
            self._userHomeTown = homeTown
        }
        
        self.userRef = FirebaseService.firebaseSerivce.userRef.childByAppendingPath(self._userKey)
    }
    
    
    
    
    
    
    
    
}
