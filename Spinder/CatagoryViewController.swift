//
//  CatagoryViewController.swift
//  Spinder
//
//  Created by Mingu Chu on 4/18/16.
//  Copyright © 2016 Kyle. All rights reserved.
//
//
//import UIKit
//
//class CatagoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

//    @IBOutlet weak var GenderTextField: UITextField!
//    @IBOutlet weak var ageTextField: UITextField!
//    @IBOutlet weak var distanceTextField: UITextField!

//    var pickerView = UIPickerView()
//    let pickerView1 = UIPickerView()
//    let pickerView2 = UIPickerView()
//    var toolBar = UIToolbar()

//    var genderOption = ["Male", "Female"]
//    var ageOption = ["Do not matter", "18 ~ 25", "26 ~33", "34 ~ 41", "42 ~ 49", "50 +"]
//    var distanceOption = ["Within 1 Miles", "Within 2 Miles", "Within 3 Miles", "Within 4 Miles", "Within 5 Miles"]
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        pickerView = UIPickerView(frame: CGRectMake(0, 200, view.frame.width, 300))
//        pickerView.backgroundColor = .whiteColor()
//        pickerView.showsSelectionIndicator = true
//        toolBar.barStyle = UIBarStyle.Default
//        pickerView.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//        pickerView.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style:.Plain, target: self, action:#selector(CatagoryViewController.doneButton))
//        toolBar.setItems([doneButton], animated: false)
//        toolBar.userInteractionEnabled = true
//        
//        
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        pickerView1.delegate = self
//        pickerView2.delegate = self
//        pickerView.tag = 101
//        pickerView1.tag = 102
//        pickerView2.tag = 103
//        GenderTextField.inputView = pickerView
//        GenderTextField.inputAccessoryView = toolBar
//        ageTextField.inputView = pickerView1
//        distanceTextField.inputView = pickerView2
    
//    }
    
//    func doneButton() {
//        GenderTextField.resignFirstResponder()
//    }

//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView.tag == 101 {
//            return genderOption.count
//        } else if pickerView.tag == 102 {
//            return ageOption.count
//        } else if pickerView.tag == 103 {
//            return distanceOption.count
//        }
//        
//        return 1
//    }
    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerView.tag == 101 {
//            return genderOption[row]
//        } else if pickerView.tag == 102 {
//            return ageOption[row]
//        } else if pickerView.tag == 103 {
//            return distanceOption[row]
//        }
//        
//        return " "
//        
//    }
    
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//        if pickerView.tag == 101 {
//            GenderTextField.text = genderOption[row]
//        } else if pickerView.tag == 102 {
//            ageTextField.text = ageOption[row]
//        } else if pickerView.tag == 103 {
//            distanceTextField.text = distanceOption[row]
//        }
//            self.view.endEditing(true)
//    }
    
//    
//    @IBAction func backButtonTapped(sender: UIButton) {
//    self.dismissViewControllerAnimated(false, completion: nil)
//
//    }
//
//
//    @IBAction func findSpinderButtonTapped(sender: AnyObject) {
//        print("Spinder Information Uploaded")
//    }
//    
//}
