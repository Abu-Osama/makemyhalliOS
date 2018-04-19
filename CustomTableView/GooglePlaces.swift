//
//  GooglePlaces.swift
//  CustomTableView
//
//  Created by Deepak mahadev on 04/04/18.
//  Copyright © 2018 deepak. All rights reserved.

import UIKit
import Alamofire

class GooglePlaces: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var srchLocation: UISearchBar!
    
    @IBOutlet weak var tblLoction: UITableView!
    var arrPlaces = NSMutableArray(capacity: 100)
    let operationQueue = OperationQueue()
    let currentLat = 51.5033640
    let currentLong = -0.1276250
    var LocationDataDelegate : LocationData! = nil
    var tblLocation : UITableView!
    var lblNodata = UILabel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        lblNodata.frame = CGRect(x: 0, y: 80, width:
            self.view.frame.size.width, height: self.view.frame.size.height-60)
        lblNodata.text = "Please enter text to get your location"
        self.view.addSubview(lblNodata)
        srchLocation.placeholder = "Ente your location details"
        lblNodata.textAlignment = .center
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.beginSearching(searchText: searchText)
    }
    
    func beginSearching(searchText:String) {
        if searchText.characters.count == 0 {
            self.arrPlaces.removeAllObjects()
            tblLoction.isHidden = true
            lblNodata.isHidden = false
            return
        }
        
        operationQueue.addOperation { () -> Void in
            self.forwardGeoCoding(searchText: searchText)
        }
    }
    
    //MARK: - Search place from Google -
    func forwardGeoCoding(searchText:String) {
        googlePlacesResult(input: searchText) { (result) -> Void in
            let searchResult:NSDictionary = ["keyword":searchText,"results":result]
            if result.count > 0
            {
                let features = searchResult.value(forKey: "results") as! NSArray
                self.arrPlaces = NSMutableArray(capacity: 100)
                print(features.count)
                for jk in 0...features.count-1
                {
                    let dict = features.object(at: jk) as! NSDictionary
                    self.arrPlaces.add(dict)
                }
                DispatchQueue.main.async(execute: {
                    if self.arrPlaces.count != 0
                    {
                        self.tblLoction.isHidden = false
                        self.lblNodata.isHidden = true
                        self.tblLoction.reloadData()
                    }
                    else
                    {
                        self.tblLoction.isHidden = true
                        self.lblNodata.isHidden = false
                        self.tblLoction.reloadData()
                    }
                });
            }
        }
    }
    
    //MARK: - Google place API request -
    func googlePlacesResult(input: String, completion: @escaping (_ result: NSArray) -> Void) {
        let searchWordProtection = input.replacingOccurrences(of: " ", with: "");        if searchWordProtection.characters.count != 0 {
            let urlString = NSString(format: "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=establishment|geocode&location=%@,%@&radius=500&language=en&key= your key",input,"\(currentLocationLatitude)","\(currentLocationLongtitude)")
            print(urlString)
            let url = NSURL(string: urlString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)
            print(url!)
            let defaultConfigObject = URLSessionConfiguration.default
            let delegateFreeSession = URLSession(configuration: defaultConfigObject, delegate: nil, delegateQueue: OperationQueue.main)
            let request = NSURLRequest(url: url! as URL)
            let task =  delegateFreeSession.dataTask(with: request as URLRequest, completionHandler:
            {
                (data, response, error) -> Void in
                if let data = data
                {
                    do {
                        let jSONresult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                        let results:NSArray = jSONresult["predictions"] as! NSArray
                        let status = jSONresult["status"] as! String
                        if status == "NOT_FOUND" || status == "REQUEST_DENIED"
                        {
                            let userInfo:NSDictionary = ["error": jSONresult["status"]!]
                            let newError = NSError(domain: "API Error", code: 666, userInfo: userInfo as [NSObject : AnyObject])
                            let arr:NSArray = [newError]
                            completion(arr)
                            return
                        }
                        else
                        {
                            completion(results)
                        }
                    }
                    catch
                    {
                        print("json error: \(error)")
                    }
                }
                else if let error = error
                {
                    print(error)
                }
            })
            task.resume()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPlaces.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tblCell = tableView.dequeueReusableCell(withIdentifier: "locationCell")
        let dict = arrPlaces.object(at: indexPath.row) as! NSDictionary
        tblCell?.textLabel?.text = dict.value(forKey: "description") as? String
        tblCell?.textLabel?.numberOfLines = 0
        tblCell?.textLabel?.sizeToFit()
        return tblCell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if LocationDataDelegate != nil
        {
            let dict = arrPlaces.object(at: indexPath.row) as! NSDictionary
            print(dict.value(forKey: "terms") as! NSArray)
            let ArrSelected = dict.value(forKey: "terms") as! NSArray
            LocationDataDelegate.didSelectLocationData(LocationData: ArrSelected)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
