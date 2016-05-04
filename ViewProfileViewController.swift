//
//  ViewProfileViewController.swift
//  Spinder
//
//  Created by Mingu Chu on 5/3/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import Firebase

class ViewProfileViewController: UIViewController {


    
    var receieverName: String!
    var receieverAge: String!
    var receieverGender: String!
    var receieverUserProfilePicture: String!
    var receieverUserHomeTown: String!
    var receieverDescription: String!

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var userGender: UILabel!
    
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userTown: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.image = conversion(receieverUserProfilePicture)
        userName.text = receieverName
        userAge.text = receieverAge
        userTown.text = receieverUserHomeTown
        userDescription.text = receieverDescription
        
        
    }
    
    
    
    //    MARK : PHOTO STRING -> IMAGE / CONVERSION
    func conversion(photo: String) -> UIImage {
        let imageData = NSData(base64EncodedString: photo, options: [] )
        let image = UIImage(data: imageData!)
        return image!
    }
    

}
