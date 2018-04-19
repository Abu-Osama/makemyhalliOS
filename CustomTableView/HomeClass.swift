
//  HomeClass.swift
//  CustomTableView
//  Created by Deepak mahadev on 13/04/18.
//  Copyright © 2018 deepak. All rights reserved.
//

import Foundation
import UIKit
class HomeClass: UIViewController,UISearchBarDelegate{
    
    
    @IBOutlet weak var serachbar: UISearchBar!
    

//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if let text = searchBar.text {
//            // here is text from the search bar
//            print(text)
//
//            //userInput = text
//
//            // now you can call 'performSegue'
//            //performSegue(withIdentifier: "searchView", sender: self)
//        }
//    }
//
    
    override func viewDidLoad() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.frame = CGRect(x: 200.0, y: 13.0, width: 24.0, height: 24.0)
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "icon.png")
        //imageView.frame = CGRect(x: 100.0, y: 13.0, width: 24.0, height: 24.0)
        imageView.image = image
        navigationItem.titleView = imageView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeClass.tappedMe))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        
    }
    
    func tappedMe()
    {
        
        let storyboard = UIStoryboard(name: "Main" , bundle: nil)
        let dec = storyboard.instantiateViewController(withIdentifier: "GoogleLocation") as! GoogleLocation
        self.navigationController?.pushViewController(dec, animated: true);
        print("Tapped on Image")
    }
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
    
}
