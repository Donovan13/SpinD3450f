//
//  CreateAccountViewController.swift
//  Spinder
//
//  Created by Kyle on 4/18/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import CoreImage

class CreateAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var userDescriptionTextView: UITextView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()


    }



    @IBAction func addPhotoButtonTapped(sender: AnyObject) {

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .PhotoLibrary
        self.presentViewController(picker, animated: true, completion: nil)
        
    }

        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            self.profileImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage;
            picker.dismissViewControllerAnimated(true, completion: nil)
            print("Profile Image Uploaded")

}
 
    @IBAction func backButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    @IBAction func createAccountButtonTapped(sender: UIButton) {
        print("User Information Uploaded")
    }
    
    
    
}