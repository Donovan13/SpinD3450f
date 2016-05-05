//
//  ActiveUser.swift
//  Spinder
//
//  Created by Mingu Chu on 5/1/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CoreLocation

class ActiveUser {
    var userID: String!
    var userName: String!
    var userAge: String!
    var userPhoto: String!
    var userDescription: String!
    var userGender: String!
    var userZipCode: String!
    var userActivity: String!
    var activityDetail: String!
    var currentLocation: CLLocationCoordinate2D!
    
    
    init(activity: String, detail: String, locationPlacemark: CLPlacemark?) {
        userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String
        let activeUserRef = FirebaseService.firebaseSerivce.activeUserRef.childByAutoId()
        userName = currentUserName
        userAge = currentUserAge
        userPhoto = currentUserProfilePicture
        userDescription = currentUserDescription
        userGender = currentUserGender
        userZipCode = currentUserZipcode
        userActivity = activity
        activityDetail = detail
        userZipCode = "\(locationPlacemark?.postalCode!)"
//        currentLocation = CLLocationCoordinate2D(latitude: locationPlacemark!.location!.coordinate.latitude, longitude: locationPlacemark!.location!.coordinate.longitude)
        let userDictionary = [
            "userID": userID!,
            "profilePicture" : userPhoto! as String,
            "name" : userName!,
            "age" : userAge!,
            "gender" : userGender!,
            "description" : userDescription!,
            "zipCode" : userZipCode!,
            "userActivity" : userActivity!,
            "activityDetail" : activityDetail!,
//            "longitude" : currentLocation!.longitude as Double,
//            "latitude" : currentLocation.latitude as Double
            ]
            activeUserRef.setValue(userDictionary)
    }
    
    init(dictionary: Dictionary<String, AnyObject>) {
        userID = dictionary["userID"] as? String
        userPhoto = dictionary["profilePicture"] as? String
        userName = dictionary["name"] as? String
        userAge = dictionary["age"] as? String
        userGender = dictionary["gender"] as? String
        userDescription = dictionary["description"] as? String
        userZipCode = dictionary["zipCode"] as? String
        userActivity = dictionary["userActivity"] as? String
        activityDetail = dictionary["activityDetail"] as? String
//        currentLocation = dictionary["currentLocation"] as? CLLocationCoordinate2D
        
        
        
        
    }
}



















