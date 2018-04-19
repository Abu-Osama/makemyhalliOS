
//  ViewController.swift
//  CustomTableView

//  Created by deepak on 30/03/18.
//  Copyright © 2017 deepak. All rights reserved.

import UIKit
import Alamofire
//import AlamofireImage

//adding class DataSource and Delegate for our TableView
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate{
    
    @IBOutlet weak var currentdate: UILabel!
   // @IBOutlet weak var currentdate: UIButton!
    //the Web API URL
    let URL_GET_DATA = "https://www.makemyhall.com/m/hallcate.php"
    var selectedImage:String?
    var selectedLabel:String?
    var  valueToPass:String=""
   // var selectedImage:String?
    //var selectedLabel:String?
    
    //for date
    let date = Date()
    let formatter = DateFormatter()
    
    let lat:String="12.9716"
    let lon:String="77.5946"
    let cat:String="MarriageHall"
    //our table view
    @IBOutlet weak var tableViewHeroes: UITableView!
    
    //a list to store heroes
    var heroes = [Hero]()
    
    //the method returning size of the list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return heroes.count
        
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
        
        
        let storyboard = UIStoryboard(name: "Main" , bundle: nil)
        let dec = storyboard.instantiateViewController(withIdentifier: "HallDetails") as! HallDetails
        
        let hero: Hero
        hero = heroes[indexPath.row]
        
       //dec.getimage = hero.imageUrl! as! Image
        
//        dec.getimage = hero.imageUr
        
          dec.getimage = hero.imageUrl!
        
         dec.getname  = hero.name!
         dec.getnumber = hero.team!
        // print(hero.imageUrl)
        self.navigationController?.pushViewController(dec, animated: true);
        
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //code to execute on click
//
//    }
    
    //the method returning each cell of the list

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
    
        //getting the hero for the specified position
        let hero: Hero
        hero = heroes[indexPath.row]
        
        //displaying values
        cell.labelName.text = hero.name
        cell.labelTeam.text = hero.team
        
        
        //displaying image
//        Alamofire.request(hero.imageUrl!).responseImage { response in
//            debugPrint(response)
//
//            if let image = response.result.value {
//                cell.heroImage.image = image
//            }
//        }
        
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for date
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        print(result)
       currentdate.text = result
        
        let calendar = Calendar.current
        let date1 = Date()
        
        //let today1 = calendar.isDateInYesterday(date1)
        //calendar.isDateInToday(date1)
        let today1=calendar.isDateInTomorrow(date1)
        
       // Calendar.current.isDateInWeekend(date1)
        
        //print(calendar)
        
        print(today1)
        let parameters: Parameters=[
            "latitude":lat,
            "longitute":lon,
            "category":cat
        ]
        //fetching data from web api
        Alamofire.request(URL_GET_DATA ,method: .post, parameters: parameters).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                //let heroesArray : NSArray  = json as! NSArray

                let jsonData = json as! NSDictionary
                
                //converting json to NSArray
                //  let heroesArray : NSArray  = json ["ok"] as! NSArray
                let heroesArray : NSArray  = jsonData ["ok"] as! NSArray
                
                
                //traversing through all elements of the array
                for i in 0..<heroesArray.count{
                    
                    //adding hero values to the hero list
                    self.heroes.append(Hero(
                        name: (heroesArray[i] as AnyObject).value(forKey: "Hall_name") as? String,
                        team: (heroesArray[i] as AnyObject).value(forKey: "hall_address") as? String,
                        imageUrl: (heroesArray[i] as AnyObject).value(forKey: "hall_banner") as? String
                    ))

                }
                //displaying data in tableview
                self.tableViewHeroes.reloadData()
            }
        
        }
        self.tableViewHeroes.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

