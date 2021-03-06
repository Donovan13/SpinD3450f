//
//  CreateAccountViewController.swift
//  Spinder
//
//  Created by Kyle on 4/18/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import CoreImage
import Firebase

class CreateAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var userDescriptionTextView: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    var genderPickerView = UIPickerView()
    let agePickerView = UIPickerView()

    
    var gender = ["Male", "Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPickerView.delegate = self
        genderPickerView.tag = 201
        genderTextField.inputView = genderPickerView

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 201 {
            return gender.count

        }
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 201 {
            return gender[row]

        }
        
        return " "
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 201 {
            genderTextField.text = gender[row]

        }
        self.view.endEditing(true)
    }
    
    
    @IBAction func addPhotoButtonTapped(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
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
        let name = nameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let age = ageTextField.text
        let gender = genderTextField.text
    
        
        FirebaseService.firebaseSerivce.FirebaseRef.createUser(email, password: password) { (error, result) in
            if error != nil {
                print(error)
            } else {
                FirebaseService.firebaseSerivce.FirebaseRef.authUser(email, password: password, withCompletionBlock: { (error, authData) in
                    let user = ["profilePicture": self.coversion(self.profileImageView.image!), "email": email!, "name": name!, "age": age!, "gender": gender!]
                    FirebaseService.firebaseSerivce.createNewAccount(authData.uid, user: user)
                    self.performSegueWithIdentifier("CreateAccountSegue", sender: self)
                })
            }
        }
    }
    
    func coversion(image: UIImage) -> String {
        let data = UIImageJPEGRepresentation(image, 0.5)
        let base64String = data!.base64EncodedStringWithOptions([])
        return base64String
    }
    
    
}

















