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
import CoreLocation

class CreateAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var userDescriptionTextView: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var zipCodeTextFiled: UITextField!
    
    var locationManager = CLLocationManager()
    var genderPickerView = UIPickerView()
    let agePickerView = UIPickerView()
    
    
    var gender = ["Male", "Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
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
    
    func textViewDidBeginEditing(textView: UITextView) {
        userDescriptionTextView.text = ""
    }
    
    @IBAction func currentLocation(sender: AnyObject) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        if location?.verticalAccuracy < 100 && location?.horizontalAccuracy < 100 {
            reverseGeodcode(location!)
            locationManager.stopUpdatingLocation()
        }
    }
    func reverseGeodcode(location:CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks:[CLPlacemark]?, error:NSError?) in
            let placemark = placemarks?.first

            self.zipCodeTextFiled.text = placemark?.postalCode
        }
        
    }
    
    @IBAction func backButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createAccountButtonTapped(sender: UIButton) {
        let name = nameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        let age = ageTextField.text
        let gender = genderTextField.text
        let photo = profileImageView.image
        let description = userDescriptionTextView.text
        let zipCode = zipCodeTextFiled.text
        
        if name != "" && email != "" && password != "" && age != "" && gender != "" && zipCode != "" && photo != nil {
            if password == confirmPassword {
                    FirebaseService.firebaseSerivce.FirebaseRef.createUser(email, password: password) { (error, result) in
                        if error != nil {
                            print(error)
                            self.errorAlert("Oops! Something went wrong", message: "please try again")
                        } else {
                            FirebaseService.firebaseSerivce.FirebaseRef.authUser(email, password: password, withCompletionBlock: { (error, authData) in
                                if error != nil {
                                    print("Account created but not logged in :\(error)")
                                } else {
                                let user = ["profilePicture": self.coversion(photo!), "email": email!, "name": name!, "age": age!, "gender": gender!, "description": description!, "zipCode": zipCode!]
                                FirebaseService.firebaseSerivce.createNewAccount(authData.uid, user: user)
                                  self.dismissViewControllerAnimated(true, completion: nil)
//                                self.performSegueWithIdentifier("createProfileSegue", sender: self)
                                }
                            })
                        }
                }
            } else {
                errorAlert("Password Does Not Match", message: "Please check your password")
            }
        } else {
            errorAlert("Fill out all areas", message: "Tip: Having a Profile Picture makes you look less creepy")
        }
    }
    
    func coversion(image: UIImage) -> String {
        let data = UIImageJPEGRepresentation(image, 0.5)
        let base64String = data!.base64EncodedStringWithOptions([])
        return base64String
    }
    
    func errorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
}

















