//
//  ViewController.swift
//  Spinder
//
//  Created by Kyle on 4/18/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import Firebase


class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
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
    }


    @IBAction func facebookLoginButtonTapped(sender: AnyObject) {
    }
    
    func errorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
}

