//
//  MapviewClass.swift
//  CustomTableView

//  Created by Deepak mahadev on 05/04/18.
//  Copyright © 2018 deepak. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import GooglePlaces
class MapviewClass: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()  // Here it is an object to get the user's location.
    
    
    let strLat : String = "12.9716"
    let strLong : String = "77.5946"

    @IBOutlet weak var mapView: MKMapView!
    
   // @IBOutlet weak var mapView: MKMapView!    // It is my map.
    
    
   // @IBOutlet fileprivate weak var mapView: GMSMapView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: ("comgooglemaps://?saddr=&daddr=\(strLat),\(strLong)&directionsmode=driving")) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        
//        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
//            UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\(strLat),\(strLong)&directionsmode=driving")!)
//        }
//        else {
//            print("Can't use comgooglemaps://");
//        }
//        let camera = GMSCameraPosition.camera(withLatitude: 37.36, longitude: -122.0, zoom: 6.0)
//        mapView.camera = camera
//        showMarker(position: camera.target)
    }
    
//    func showMarker(position: CLLocationCoordinate2D){
//        let marker = GMSMarker()
//        marker.position = position
//        marker.title = "Palo Alto"
//        marker.snippet = "San Francisco"
//        marker.map = mapView
//    }
}
    
    
   

        

