//
//  HallDetails.swift
//  CustomTableView
//
//  Created by Deepak mahadev on 29/03/18.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import MapKit

class HallDetails :UIViewController{
    
    var getname = String()
    var getimage = String()
    var getnumber = String()
    
    var valueToPass: String!
    
    @IBAction func mapbtn(_ sender: Any) {
    
       
        
    }
   
    
    @IBOutlet weak var hallnumber: UILabel!
    @IBOutlet weak var hallname: UILabel!
    @IBOutlet weak var imageviewhall: UIImageView!
   // @IBOutlet weak var hallname1: UITextView!
    //@IBOutlet weak var imageviewhall: UIImageView!
  //  @IBOutlet weak var hallnumber: UILabel!
    //@IBOutlet weak var hallname: UILabel!
    //@IBOutlet weak var imageviewhall: UIImageView!
    
   // @IBOutlet var hallname: UIView!
    
  //  @IBOutlet weak var labelname: UILabel!
    
    override func viewDidLoad() {
        
        
        print("row::"+""+getimage)
        
        let url = URL(string: getimage)
        // this downloads the image asynchronously if it's not cached yet
        imageviewhall.kf.setImage(with: url)
        
         //let  imageviewhall = UIImageView()
        //let data = NSData(contentsOfURL: NSURL(string: getimage)! as URL)
        //imageviewhall.image = UIImage(data: data!)
        
        // let bottomImage:UIImage = UIImage(named: getimage)!
        
       // imageviewhall.image = UIImage (named: getimage)
        hallname.text!=getname
        hallnumber.text!=getnumber
        //hallname1.text!=getnumber
        
    
}
    
    override func didReceiveMemoryWarning() {
        
    
    
    }
    
    
}
