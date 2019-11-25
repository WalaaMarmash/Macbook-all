//
//  MapViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 8/1/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    
    static  var _PlaceList = [PlaceListResultModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpMapView()
       
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

        func SetUpMapView()  {
            // Create a GMSCameraPosition that tells the map to display the
            // coordinate -33.86,151.20 at zoom level 6.
            
            if MapViewController._PlaceList.count == 0{
                let camera = GMSCameraPosition.camera(withLatitude:32.22111 , longitude:35.25444 , zoom: 17.0)
                let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
                self.view = mapView
                
                
                let alert = UIAlertController(title: "لا يوجد مناطق مختارة", message: "قم باختيار مناطق العمل ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
            
            else{
                
                
                if   let locationLat = MapViewController._PlaceList[0].LatRegion, let  locationLong = MapViewController._PlaceList[0].LongRegion {
                    
                    if  let lang = Double(locationLat),
                        let long = Double(locationLong){
                        
                        let camera = GMSCameraPosition.camera(withLatitude:lang , longitude:long , zoom: 17.0)
                        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
                        self.view = mapView
                        for item in MapViewController._PlaceList{
                            
                            let lang = Double(item.LatRegion!)
                            let long = Double(item.LongRegion!)
                            
                            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude:lang! , longitude: long!))
                            marker.title = item.Name
                            marker.snippet = item.Name
                            marker.map = mapView
                        }
                    }
                    
                    
                }
                else{
                    
                    let camera = GMSCameraPosition.camera(withLatitude:32.22111 , longitude:35.25444 , zoom: 17.0)
                    let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
                    self.view = mapView
                    
                    for item in MapViewController._PlaceList{
                        
                        let lang = Double(item.LatRegion!)
                        let long = Double(item.LongRegion!)
                        
                        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude:lang! , longitude: long!))
                        marker.title = item.Name
                        marker.snippet = item.Name
                        marker.map = mapView
                    }
                }
                
            }
            
            
            
          
            
          
//
//
//            print(MapViewController._PlaceList.count)
//
//            for item in MapViewController._PlaceList{
//
//            // Creates a marker in the center of the map.
//            let marker = GMSMarker()
//            let lang = Double(item.LatRegion!)
//            let long = Double(item.LongRegion!)
//
//            let position = CLLocationCoordinate2D(latitude: lang!, longitude: long!)
//            marker.position = position
//            marker.title = item.Name
//           // marker.snippet = "Australia"
//            marker.map = mapView
          
            }
            
           // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: "next")
       // }
    

}
