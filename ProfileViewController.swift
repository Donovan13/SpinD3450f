//
//  ProfileViewController.swift
//  Spinder
//
//  Created by Mingu Chu on 5/1/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import Firebase
import CoreImage



class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var currentUserData = [FDataSnapshot]()
    var currentUser = Dictionary<String, AnyObject>()
    var picker = UIImagePickerController()
    
//    MARK : OULETS
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var genderText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var changePhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserProfile()
        editFalse()
        doneButton.hidden = true
        changePhoto.hidden = true
    }
    
    @IBAction func editButton(sender: AnyObject) {
        editTrue()
        doneButton.hidden = false
        editButton.hidden = true
    }
    @IBAction func doneButton(sender: AnyObject) {
        editFalse()
        editButton.hidden = false
        doneButton.hidden = true
        let editedUserDict = [
            "name"              : self.nameText.text,
            "gender"            : self.genderText.text,
            "age"               : self.ageText.text,
            "zipCode"           : self.zipCode.text,
            "description"       : self.descriptionText.text,
            "profilePicture"    : imageCoversion(self.profileImage.image!)]
        FirebaseService.firebaseSerivce.currentUserRef.updateChildValues(editedUserDict)
    }
    
    @IBAction func changePhoto(sender: AnyObject) {
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .PhotoLibrary
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func logOutButton(sender: AnyObject) {
        FirebaseService.firebaseSerivce.currentUserRef.unauth()
        performSegueWithIdentifier("LogOutSegue", sender: self)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.profileImage.image = info[UIImagePickerControllerEditedImage] as? UIImage;
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadUserProfile () {
        FirebaseService.firebaseSerivce.currentUserRef.observeEventType(.Value) { (snapshot: FDataSnapshot!) in
            self.currentUser = snapshot.value as! Dictionary<String, AnyObject>
            self.nameText.text = self.currentUser["name"] as? String
            self.genderText.text = self.currentUser["gender"] as? String
            self.ageText.text = self.currentUser["age"] as? String
            self.zipCode.text = self.currentUser["zipCode"] as? String
            self.descriptionText.text = self.currentUser["description"] as? String
            self.profileImage.image = self.stringConversion(self.currentUser["profilePicture"] as! String)
        }
    }
    
    func editTrue() {
        nameText.enabled = true
        genderText.enabled = true
        ageText.enabled = true
        zipCode.enabled = true
        descriptionText.userInteractionEnabled = true
        changePhoto.hidden = false
    }
    func editFalse() {
        nameText.enabled = false
        genderText.enabled = false
        ageText.enabled = false
        zipCode.enabled = false
        descriptionText.userInteractionEnabled = false
        changePhoto.hidden = true
    }
    
    //    MARK : CONVERSION
    func stringConversion(photo: String) -> UIImage {
        let imageData = NSData(base64EncodedString: photo, options: [] )
        let image = UIImage(data: imageData!)
        return image!
    }
    func imageCoversion(image: UIImage) -> String {
        let data = UIImageJPEGRepresentation(image, 0.5)
        let base64String = data!.base64EncodedStringWithOptions([])
        return base64String
    }
    
}
