//
//  ActivityViewController.swift
//  Spinder
//
//  Created by Mingu Chu on 4/18/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    
    @IBOutlet weak var GenderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    
    var genderPickerView = UIPickerView()
    let agePickerView = UIPickerView()
    let distancePickerView = UIPickerView()
    var toolBar = UIToolbar()
    var activity = [String]()
    
    var genderOption = ["Male", "Female"]
    var ageOption = ["Do not matter", "18 ~ 25", "26 ~33", "34 ~ 41", "42 ~ 49", "50 +"]
    var distanceOption = ["Within 1 Miles", "Within 2 Miles", "Within 3 Miles", "Within 4 Miles", "Within 5 Miles"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity = ["Basketball", "Soccer", "VolleyBall", "BaseBall", "Fitness"]
        
        genderPickerView = UIPickerView(frame: CGRectMake(0, 200, view.frame.width, 300))
        genderPickerView.backgroundColor = .whiteColor()
        genderPickerView.showsSelectionIndicator = true
        toolBar.barStyle = UIBarStyle.Default
        genderPickerView.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        genderPickerView.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style:.Plain, target: self, action:#selector(ActivityViewController.doneButton))
        toolBar.setItems([doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        agePickerView.delegate = self
        distancePickerView.delegate = self
        genderPickerView.tag = 101
        agePickerView.tag = 102
        distancePickerView.tag = 103
        GenderTextField.inputView = genderPickerView
        GenderTextField.inputAccessoryView = toolBar
        ageTextField.inputView = agePickerView
        distanceTextField.inputView = distancePickerView
        
    }
    
    
    func doneButton() {
        GenderTextField.resignFirstResponder()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 101 {
            return genderOption.count
        } else if pickerView.tag == 102 {
            return ageOption.count
        } else if pickerView.tag == 103 {
            return distanceOption.count
        }
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 101 {
            return genderOption[row]
        } else if pickerView.tag == 102 {
            return ageOption[row]
        } else if pickerView.tag == 103 {
            return distanceOption[row]
        }
        
        return " "
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 101 {
            GenderTextField.text = genderOption[row]
        } else if pickerView.tag == 102 {
            ageTextField.text = ageOption[row]
        } else if pickerView.tag == 103 {
            distanceTextField.text = distanceOption[row]
        }
        self.view.endEditing(true)
    }
    
    
    @IBAction func findSpinderButtonTapped(sender: AnyObject) {
        print("Spinder Information Uploaded")
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath)
        cell.textLabel?.text = activity[indexPath.row]
        return cell
    }
    
}
