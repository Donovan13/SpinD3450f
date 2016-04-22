//
//  ViewController.swift
//  Spinder
//
//  Created by Kyle on 4/18/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import Firebase


class LogInViewController: UIViewController, UITextFieldDelegate {
    //    MARK : OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    //    MARK : VARIABLES AND LET S
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
    //    MARK : LOGIN BUTTON
    @IBAction func loginButtonTapped(sender: AnyObject) {
        let email = emailTextField.text
        let password = passwordTextField.text
        if email?.characters.count > 0 && password?.characters.count > 0 {
            FirebaseService.firebaseSerivce.FirebaseRef.authUser(email, password: password) { (error, authData) in
                if error != nil {
                    print(error)
                    self.errorAlert("Invalid User Info", message: "Username or Password does not match our data")
                } else {
                    self.userDefault.setValue(authData.uid, forKey: "uid")
                    print(FirebaseService.firebaseSerivce.currentUserRef)
                    self.performSegueWithIdentifier("LogInSegue", sender: self)
                }
            }
        } else {
            errorAlert("Log In Error", message: "Please Enter Email and Password")
        }
    }
    
    //    MARK : TEXTFIELD DELEGATE
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if emailTextField.isFirstResponder() {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if passwordTextField.isFirstResponder() {
            loginButtonTapped(logInButton)
        }
        return true
    }
    
    @IBAction func facebookLoginButtonTapped(sender: AnyObject) {
        
    }
    
    //    MARK : ALERT
    func errorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
}

