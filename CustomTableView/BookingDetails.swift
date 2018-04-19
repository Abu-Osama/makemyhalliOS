//
//  BookingDetails.swift
//  CustomTableView
//
//  Created by Deepak mahadev on 09/04/18.
//  Copyright © 2018 deepak. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class BookingDetails :UIViewController{
    
    let URL_hall_details="http://www.makemyhall.com/m/makemyhallbooking.php"
    

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var useremailid: UITextField!
    
    @IBOutlet weak var usermobile: UITextField!
    
    @IBAction func sendData(_ sender: Any) {
    
            let parameters: Parameters=[
                "name":username.text!,
                "email":useremailid.text!,
                "phone":usermobile.text!,]
        
            
            Alamofire.request(URL_hall_details, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    //printing response
                    print(response)
                    
                    //getting the json value from the server
                    if let result = response.result.value {
                        
                        //converting it as NSDictionary
                        let jsonData = result as! NSDictionary
                        //print("JSON: \(jsonData)")
                        print(jsonData.value(forKey: "messqge") as Any)
                        
//                        self.showToast(message: "successful done")
                        
                        //displaying the message in label
                        // self.labelMessage.text = jsonData.value(forKey: "message") as! String?
                    }
            }
            
    }
    
    
    override func viewDidLoad() {
        
        
    
    }
    
    override func didReceiveMemoryWarning() {
    
    }

    
    
    
}
