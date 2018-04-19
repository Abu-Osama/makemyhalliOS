
//  ShowServicesList.swift
//  CustomTableView

//  Created by Deepak mahadev on 09/04/18.
//  Copyright © 2018 deepak. All rights reserved.


import Foundation
import UIKit
import Alamofire
import AlamofireImage

class ShowServicesList : UIViewController,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var tablewviewforlist: UITableView!
    //@IBOutlet weak var tablewviewforlist: UITableView!
    
    //@IBOutlet var tablewviewforlist: UITableView!
    //@IBOutlet weak var tablewviewforlist: UITableView!
    
   // @IBOutlet weak var tableviewlist1: UITableView!
    //@IBOutlet weak var tableviewlist1: UITableView!
    let URL_GET_DATA = "https://www.makemyhall.com/m/hallcate.php"
   // let lat:String="12.9716"
   // let lon:String="77.5946"
    
    
   // @IBOutlet weak var tableviewList: UITableView!
   // @IBOutlet weak var tableviewlist: UITableView!
    var list = [ListServices]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return list.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("rowselected: \(indexPath.row)")
        
        // let courtle = Hero()
        
        
        //let values = [Hero]()
        
        
        // let value = values[indexPath.row]
        
        //        let hero: Hero
        //        hero = heroes[indexPath.row]
        // hero = heroes[indexPath.row]
        
        // print(hero)
        
        
//        let storyboard = UIStoryboard(name: "Main" , bundle: nil)
//        let dec = storyboard.instantiateViewController(withIdentifier: "HallDetails") as! HallDetails
//
//        let hero: ListServices
//        hero = list[indexPath.row]
//
//        //dec.getimage = hero.imageUrl! as! Image
//
//        //        dec.getimage = hero.imageUr
//
//        dec.getimage = hero.serviceimageUrl!
//
//        dec.getname  = hero.servicesname!
//       // dec.getnumber = hero.team!
//        // print(hero.imageUrl)
//        self.navigationController?.pushViewController(dec, animated: true);
        
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        //code to execute on click
    //
    //    }
    
    //the method returning each cell of the list
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ServicesTableViewCell
        
        //getting the hero for the specified position
        let hero: ListServices
        hero = list[indexPath.row]
        
        //displaying values
        cell.bannerlabel.text = hero.servicesname
        //cell.labelTeam.text = hero.team
        
        
        //displaying image
        Alamofire.request(hero.serviceimageUrl!).responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                cell.imagebanner.image = image
            }
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        
//        let parameters: Parameters=[
//            "latitude":lat,
//            "longitute":lon,
//        ]
        //fetching data from web api
        Alamofire.request(URL_GET_DATA ).responseJSON {
            response in
            
            print(response)
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                //let heroesArray : NSArray  = json as! NSArray
                
                let jsonData = json as! NSDictionary
                
                //converting json to NSArray
                //  let heroesArray : NSArray  = json ["ok"] as! NSArray
                let heroesArray1 : NSArray  = jsonData ["ok"] as! NSArray//
                
                
                //traversing through all elements of the array
                for i in 0..<heroesArray1.count{
                    
                    //adding hero values to the hero list
                    self.list.append(ListServices(
                        servicesname: (heroesArray1[i] as AnyObject).value(forKey: "Hall_name") as? String,
                        //team: (heroesArray[i] as AnyObject).value(forKey: "hall_address") as? String,
                        serviceimageUrl: (heroesArray1[i] as AnyObject).value(forKey: "hall_banner") as? String
                    ))
                }
                //print(self.tablewviewforlist)
                //displaying data in tableview
                self.tablewviewforlist.reloadData()
            }
            
        }
    
        self.tablewviewforlist.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    
    
    
}
