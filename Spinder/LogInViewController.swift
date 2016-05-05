//
//  ViewController.swift
//  Spinder
//
//  Created by Kyle on 4/18/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import Firebase
import MediaPlayer
import AVKit


class LogInViewController: UIViewController, UITextFieldDelegate {
    
    //    MARK : OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet var pageContol: UIPageControl!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!

    
    //    MARK : VARIABLES AND LET S
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    var images: [UIImage] = []
    var image1 = UIImage(named: "firstMessage.png")
    var image2 = UIImage(named: "secondMessage.png")
    var image3 = UIImage(named: "thirdMessage.png")
    
    var textHeadingArray = ["Hello Chicago!", "New friends await!", "Time to login!"]
    var textContentArray = ["So much to see!", "Dont be shy!", "Go have fun!!"]
    
    var moviePlayerController = MPMoviePlayerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()


        let filePath = NSBundle.mainBundle().pathForResource("black", ofType: "mp4")
        print("\(filePath)")
        
        self.moviePlayerController.contentURL = NSURL.fileURLWithPath(filePath!)
        self.moviePlayerController.prepareToPlay()
        self.moviePlayerController.view.frame = UIScreen.mainScreen().bounds
        
        self.moviePlayerController.controlStyle = .None
        self.moviePlayerController.scalingMode = MPMovieScalingMode.Fill
        self.moviePlayerController.repeatMode = MPMovieRepeatMode.One
        self.backgroundView.addSubview(self.moviePlayerController.view)
        
        let leftswap = UISwipeGestureRecognizer(target: self, action: #selector(LogInViewController.handleSwap(_:)))
        let rightswap = UISwipeGestureRecognizer(target: self, action: #selector(LogInViewController.handleSwap(_:)))
        
        leftswap.direction = .Left
        rightswap.direction = .Right
        view.addGestureRecognizer(leftswap)
        view.addGestureRecognizer(rightswap)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LogInViewController.keyboardFrameWillChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        
//        print("\(FirebaseService.firebaseSerivce.currentUserRef.authData)")
//        print("\(FirebaseService.firebaseSerivce.currentUserRef)")
    }
    // Change view for keyboard
    
    func keyboardFrameWillChange(notification: NSNotification) {
        let keyboardBeginFrame = (notification.userInfo! as NSDictionary).objectForKey(UIKeyboardFrameBeginUserInfoKey)!.CGRectValue
        let keyboardEndFrame = (notification.userInfo! as NSDictionary).objectForKey(UIKeyboardFrameEndUserInfoKey)!.CGRectValue
        
        let animationCurve = UIViewAnimationCurve(rawValue: (notification.userInfo! as NSDictionary).objectForKey(UIKeyboardAnimationCurveUserInfoKey)!.integerValue)
        
        let animationDuration: NSTimeInterval = (notification.userInfo! as NSDictionary).objectForKey(UIKeyboardAnimationDurationUserInfoKey)!.doubleValue
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        UIView.setAnimationCurve(animationCurve!)
        
        var newFrame = self.view.frame
        let keyboardFrameEnd = self.view.convertRect(keyboardEndFrame, toView: nil)
        let keyboardFrameBegin = self.view.convertRect(keyboardBeginFrame, toView: nil)
        
        newFrame.origin.y -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y)
        self.view.frame = newFrame;
        
        UIView.commitAnimations()
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.moviePlayerController.stop()
//        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    override func viewDidAppear(animated: Bool) {
        self.moviePlayerController.play()
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
    
    func handleSwap(sender:UISwipeGestureRecognizer){
        if(sender.direction == .Left){
            pageContol.currentPage += 1
            firstLabel.text = textHeadingArray[pageContol.currentPage]
            secondLabel.text = textContentArray[pageContol.currentPage]
            
        }
        
        if(sender.direction == .Right){
            pageContol.currentPage -= 1
            firstLabel.text = textHeadingArray[pageContol.currentPage]
            secondLabel.text = textContentArray[pageContol.currentPage]
        }
    }
    
    @IBAction func slideTheScreen(sender: AnyObject) {
        firstLabel.text = textHeadingArray[pageContol.currentPage]
        secondLabel.text = textContentArray[pageContol.currentPage]
    }
    
    //    MARK : TEXTFIELD DELEGATE
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if emailTextField.isFirstResponder() {
            emailTextField.resignFirstResponder()
            
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

