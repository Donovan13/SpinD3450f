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

        let item1 = ParallaxItem(image: UIImage(named: "image1")!, text: "Go run with someone!")
        let item2 = ParallaxItem(image: UIImage(named: "image2")!, text: "Puppy Play Date!")
        let item3 = ParallaxItem(image: UIImage(named: "image3")!, text: "Beach games with new friends!!")
        let item4 = ParallaxItem(image: UIImage(named: "image4")!, text: "Walk your baby with another mom! Woo!!")
        
        
        
        let ParallaxViewController = Parallax(items: [item1, item2, item3, item4], motion: false)
        ParallaxViewController.completionHandler = {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                ParallaxViewController.view.alpha = 0.0
            })
        }
        
        // Adding parallax view controller.
        self.addChildViewController(ParallaxViewController)
        self.view.addSubview(ParallaxViewController.view)
        ParallaxViewController.didMoveToParentViewController(self)
        
//        print("\(FirebaseService.firebaseSerivce.currentUserRef.authData)")

//        print("\(FirebaseService.firebaseSerivce.currentUserRef)")
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
                    print("\(authData.uid)")
//                    print(FirebaseService.firebaseSerivce.currentUserRef)
                    self.performSegueWithIdentifier("LogInSeuge", sender: self)
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
    
    
    //    MARK : ALERT
    func errorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

