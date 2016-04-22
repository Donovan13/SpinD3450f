//
//  Users.swift
//  Spinder
//
//  Created by Mingu Chu on 4/19/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import Foundation
import Firebase

struct SpinderUser {
    let uid: String
    let email: String
    let password: String
    let name: String
    let age: Int
    let gender: String

    
    
    init(authData: FAuthData) {
        uid = authData.uid
        email = authData.providerData["email"] as! String
        password = authData.providerData["password"] as! String
        name = authData.providerData["name"] as! String
        age = authData.providerData["age"] as! Int
        gender = authData.providerData["gender"] as! String

        
        
    }
    
    init(uid: String, email: String, password: String, name: String, age: Int, gender: String, latitude: Double, longitude: Double) {
        self.uid = uid
        self.email = email
        self.password = password
        self.name = name
        self.age = age
        self.gender = gender

        
    }
    
}
