//
//  OrderDetailMapViewController.swift
//  TOGOTransporter
//
//  Created by Fratello Software Group on 9/19/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import GoogleMaps

class OrderDetailMapViewController: UIViewController , GMSMapViewDelegate ,  CLLocationManagerDelegate {
    
   @IBOutlet weak var googleMaps: GMSMapView!
   var locationManager = CLLocationManager()
   
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        //Your map initiation code
        let camera = GMSCameraPosition.camera(withLatitude:  ((TransporterLoader._OrderDetailsResult[0].LatSender)?.doubleValue)!, longitude: ((TransporterLoader._OrderDetailsResult[0].LongSender)?.doubleValue)!, zoom: 17.0)
        
        self.googleMaps.camera = camera
        self.googleMaps.delegate = self
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
        
       
        createMarker(titleMarker: "عنوان المرسل", iconMarker: #imageLiteral(resourceName: "icons8-place-marker-48") , latitude: ((TransporterLoader._OrderDetailsResult[0].LatSender)?.doubleValue)!, longitude: ((TransporterLoader._OrderDetailsResult[0].LongSender)?.doubleValue)!)
        
        createMarker(titleMarker: "عنوان المستقبل", iconMarker: #imageLiteral(resourceName: "icons8-place-marker-48") , latitude: ((TransporterLoader._OrderDetailsResult[0].LatReciver)?.doubleValue)!, longitude: ((TransporterLoader._OrderDetailsResult[0].LongReciver)?.doubleValue)!)
    }
    
    // MARK: function for create a marker pin on map
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        print(latitude)
        print(longitude)
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMaps
    }
    
    //MARK: - Location Manager delegates
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        //        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        let locationTujuan = CLLocation(latitude: 37.784023631590777, longitude: -122.40486681461333)
        
//        createMarker(titleMarker: "Lokasi Tujuan", iconMarker: #imageLiteral(resourceName: "Map Pin-96") , latitude: locationTujuan.coordinate.latitude, longitude: locationTujuan.coordinate.longitude)
//
//        createMarker(titleMarker: "Lokasi Aku", iconMarker: #imageLiteral(resourceName: "Map Pin-96") , latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        
       
        //        self.googleMaps?.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
    }
    
    // MARK: - GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        googleMaps.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
        googleMaps.isMyLocationEnabled = true
        
        
        
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        googleMaps.isMyLocationEnabled = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)") // when you tapped coordinate
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        googleMaps.isMyLocationEnabled = true
        googleMaps.selectedMarker = nil
        return false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}
