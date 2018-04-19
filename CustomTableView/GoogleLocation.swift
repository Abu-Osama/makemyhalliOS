//
//  GoogleLocation.swift
//  CustomTableView
//  Created by Deepak mahadev on 17/04/18.
//  Copyright © 2018 deepak. All rights reserved.


import Foundation
import UIKit



class GoogleLocation:UIViewController,UINavigationControllerDelegate,
UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource{
    
   // @IBOutlet weak var fromdate: UITextField!
    var datePicker : UIDatePicker!
    
    @IBOutlet weak var categoryUi: UITextField!
    

    @IBOutlet weak var listofitem: UIPickerView!
    //for date
    let date = Date()
    let formatter = DateFormatter()
    
    let list = ["MarriageHall","PartyHall","MeetingHall","conferenceHall","ExhibitionHall","EventHall"]
    
    
    @IBOutlet weak var todate: UILabel!
   // @IBOutlet weak var fromdate: UILabel!
    
    @IBOutlet weak var fromdate1: UILabel!
    
    
  

    override func viewDidLoad() {
        
        //fromdate.delegate = self
        fromdate1.layer.borderWidth = 0.5
        fromdate1.layer.borderColor = UIColor.green.cgColor
        
        todate.layer.borderWidth = 0.5
        todate.layer.borderColor = UIColor.green.cgColor
       //for date set on uilabel
        let today = Date()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        let tomorr = Calendar.current.date(byAdding: .day, value: 1, to: today)
        let tommrrow =  formatter.string(from: tomorr!)
        print(tommrrow)
        print(result)
        fromdate1.text = result
        todate.text! = tommrrow
    
       
       
    }
    

    
    override func didReceiveMemoryWarning() {
        

    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return list.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return list[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.categoryUi.text = self.list[row]
        self.listofitem.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //self.pickUpDate(self.fromdate)
        
        if textField == self.categoryUi {
            self.listofitem.isHidden = false
            //if you dont want the users to se the keyboard type:
            
            textField.endEditing(true)
        }
        
    }
    
    
    
    //for datepicker
    //MARK:- Function of datePicker
    
  //  func textFieldDidBeginEditing(_ textField: UITextField) {
       // self.pickUpDate(self.textField_Date)
    //}
    
//    func pickUpDate(_ textField : UITextField){
//
//        // DatePicker
//        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
//        self.datePicker.backgroundColor = UIColor.white
//        self.datePicker.datePickerMode = UIDatePickerMode.date
//        textField.inputView = self.datePicker
//
//        let todaysDate = Date()
//
//        datePicker.minimumDate = todaysDate
//
//        // ToolBar
//        let toolBar = UIToolbar()
//        toolBar.barStyle = .default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
//        toolBar.sizeToFit()
//
//        // Adding Button ToolBar
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(GoogleLocation.doneClick))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(GoogleLocation.cancelClick))
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//        textField.inputAccessoryView = toolBar
//
//    }
//
//    // MARK:- Button Done and Cancel
//    func doneClick() {
//        let dateFormatter1 = DateFormatter()
//        dateFormatter1.dateStyle = .medium
//        dateFormatter1.timeStyle = .none
//        fromdate.text = dateFormatter1.string(from: datePicker.date)
//        fromdate.resignFirstResponder()
//    }
//    func cancelClick() {
//        fromdate.resignFirstResponder()
//    }
//
//
//    //for return key function
//    func textFieldShouldReturn(_ textField : UITextField) -> Bool {   //delegate method
//        textField.resignFirstResponder()
//        return true
//    }
    
    
}
